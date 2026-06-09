import SearchStep from "../general/SearchStep";
import { useSearch } from '@/contexts/SearchContext';
import ResultSummary from "./ResultSummary";
import { getSearchResults } from "@/db/queries/search.js"
import { useEffect, useState } from "react";
import ModalWarning from "@/components/search/result/ModalWarning.jsx";

function SearchResults() {

    const {selectedData, andOrTuple} = useSearch();

    // Get results data
    // SelectedData is an object with the following structure:
        // selectedData: {
        //     TF: Array of selected transcription factors by id
        //     Species: Array of selected species by id
        //     Techniques: Array of selected experimental techniques by catid.techid
        // }

    const [results, setResults] = useState(new Map())
    const [modalIsOpen, setModalIsOpen] = useState(false)
    const [modalData, setModalData] = useState({
        tfValid: false,
        speciesValid: false,
        techniquesValid: false,
        emptyResult: false
    })
    const [loading, setLoading] = useState(true)
 
    useEffect(() => {
        const newTfValid = selectedData.TF && selectedData.TF.length > 0;
        const newSpeciesValid = selectedData.Species && selectedData.Species.length > 0;
        const newTechniquesValid = selectedData.Techniques && selectedData.Techniques.length > 0;

        if (newTfValid && newSpeciesValid && newTechniquesValid) {
            let initResults = new Map()
            getSearchResults(selectedData.TF, selectedData.Species).then((res => {
                if (res.length === 0) {
                    setLoading(false);
                    setModalData({
                        tfValid: newTfValid,
                        speciesValid: newSpeciesValid,
                        techniquesValid: newTechniquesValid,
                        emptyResult: true
                    });
                    setModalIsOpen(true);
                    return;
                }

                const technqiuesSelected = selectedData.Techniques;
                const firstConditionFilter = [];
                const secondConditionFilter = [];
                const thirdConditionFilter = [];

                if(technqiuesSelected.length > 0) {
                    technqiuesSelected.forEach(obj => {
                        const [searchNumber, categoryId, techniqueId] = obj.id.split('-');
                        if (searchNumber === '0') {
                            firstConditionFilter.push(techniqueId)
                        }
                        else if (searchNumber === '1') {
                            secondConditionFilter.push(techniqueId)
                        }
                        else if (searchNumber === '2') {
                            thirdConditionFilter.push(techniqueId)
                        }
                    })
                }
                
                res.forEach(row => {
                    //1: Unique instance for each result
                    const key = `${row.TF_name}-${row.uniprot_accession}-${row.TF_species}`
                    if (!initResults.has(key)) {
                        initResults.set(key, {
                            TF_name: row.TF_name,
                            uniprot_accession: row.uniprot_accession,
                            TF_species: row.TF_species,
                            table_data: new Map() //Map() with the rows of the results table. Each map is a row and its value has all the properties.
                        })
                    }

                    //2: Unique instance for each table row from each result

                    let dataKey = `${row.TF_name}-${row.uniprot_accession}-${row.TF_species}-${row.annotated_seq}-${row.curation_id}`
                    const tableData = initResults.get(key).table_data

                    if (!tableData.has(dataKey)) {
                            tableData.set(dataKey, {
                            curation_id: row.curation_id,
                            publication_type: row.publication_type,
                            pmid: row.pmid,
                            annotated_seq: row.annotated_seq,
                            TF_type: row.TF_type,
                            start: row.start,
                            end: row.end,
                            strand: row.strand,
                            genome_accession: row.genome_accession,
                            techniques: [],
                            gene_regulation: []
                        })
                    }

                    //3: We add only techniques and gene regualtions not repeated to its corresponding row

                    const currentData = tableData.get(dataKey);

                    const techKey = `${row.technique_id}`;
                    if (!currentData.techniques.some(t => `${t.technique_id}` === techKey)) {
                        currentData.techniques.push({ technique_id: row.technique_id, tech_name: row.tech_name, EO_term: row.EO_term });
                    }

                    const geneKey = `${row.gene_name}-${row.locus_tag}`;
                    if (!currentData.gene_regulation.some(g => `${g.gene_name}-${g.locus_tag}` === geneKey)) {
                        currentData.gene_regulation.push({ gene_name: row.gene_name, locus_tag: row.locus_tag, TF_function: row.TF_function, evidence_type: row.evidence_type });
                    }
                
                });

                //4: Filter the results based on the selected techniques
                console.log("First condition filter: ", firstConditionFilter);
                console.log("Second condition filter: ", secondConditionFilter);
                console.log("Third condition filter: ", thirdConditionFilter);
                console.log("And/Or tuple: ", andOrTuple);
                console.log("Initial results before filtering: ", initResults);
                
                if (firstConditionFilter.length > 0 || secondConditionFilter.length > 0 || thirdConditionFilter.length > 0) {
                    const keysToDelete = [];

                    initResults.forEach((value, key) => {
                        value.table_data.forEach((rowData, rowKey) => {
                            const hasFirst = rowData.techniques.some(tech => firstConditionFilter.includes(`${tech.technique_id}`));
                            const hasSecond = rowData.techniques.some(tech => secondConditionFilter.includes(`${tech.technique_id}`));
                            const hasThird = rowData.techniques.some(tech => thirdConditionFilter.includes(`${tech.technique_id}`));

                            let keep = false;

                            if (firstConditionFilter.length > 0) {
                                if (andOrTuple[0]) { // AND
                                    keep = hasFirst;
                                } else { // OR
                                    if (hasFirst) {
                                        keep = true;
                                    } else if (secondConditionFilter.length > 0) {
                                        if (andOrTuple[1]) { // AND
                                            keep = hasSecond;
                                        } else { // OR
                                            keep = hasSecond || hasThird;
                                        }
                                    } else {
                                        keep = hasThird;
                                    }
                                }
                            } else if (secondConditionFilter.length > 0) {
                                if (andOrTuple[1]) { // AND
                                    keep = hasSecond;
                                } else { // OR
                                    keep = hasSecond || hasThird;
                                }
                            } else if (thirdConditionFilter.length > 0) {
                                keep = hasThird;
                            }

                            if (!keep) {
                                value.table_data.delete(rowKey);
                            }
                        });

                        if (value.table_data.size === 0) {
                            keysToDelete.push(key);
                        }
                    });

                    keysToDelete.forEach(key => initResults.delete(key));
                }
                
                //5: Sort the results by TF_name and TF_species
                const sortedResults = new Map(
                    Array.from(initResults.entries()).sort(([, valA], [, valB]) => {
                        const nameA = valA.TF_name.toLowerCase();
                        const nameB = valB.TF_name.toLowerCase();
                        if (nameA < nameB) return -1;
                        if (nameA > nameB) return 1;

                        const speciesA = valA.TF_species.toLowerCase();
                        const speciesB = valB.TF_species.toLowerCase();
                        return speciesA.localeCompare(speciesB);
                    })
                );
                setLoading(false);
                setResults(sortedResults);
            }))
        }
        else {
            setModalData ({
                tfValid: newTfValid,
                speciesValid: newSpeciesValid,
                techniquesValid: newTechniquesValid,
                emptyResult: false
            })
            setModalIsOpen(true);
        }
    }, [])

    return (
        <>
            {loading && !modalIsOpen? (
                <div className="animate-pulse text-gray-500 font-semibold text-2xl text-center">
                    Loading...
                </div>
                ) : 
                (
                    Array.from(results.entries()).map(([summaryId, summaryData]) =>  <ResultSummary key={summaryId} result={summaryData}/>)
                )
            }
            {(modalIsOpen && modalData) && 
            (<ModalWarning onClose={() => setModalIsOpen(false)} 
                tfValid={modalData.tfValid} 
                speciesValid={modalData.speciesValid} 
                techniquesValid={modalData.techniquesValid} 
                emptyResult={modalData.emptyResult}>
            </ModalWarning>)}
        </>
    );
}
export default SearchResults;