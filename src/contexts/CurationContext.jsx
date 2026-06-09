import { createContext, useContext, useState } from "react";

const CurationContext = createContext();

export function useCuration() {
  // Hook per llegir/escriure l'estat del pipeline des de qualsevol step
  return useContext(CurationContext);
}

export function CurationProvider({ children }) {
  // Control del pas actual del pipeline
  const [currentStep, setCurrentStep] = useState(1);

  // Step 1 – publicació seleccionada
  const [publication, setPublication] = useState(null);

  // Step 2 – TF i llistes d’accessions
  const [tf, setTf] = useState(null);
  const [genomeList, setGenomeList] = useState([]);
  const [uniprotList, setUniprotList] = useState([]);
  const [refseqList, setRefseqList] = useState([]);

  // Dades extra del Step 2 (checkboxes + textos d’organisme)
  const [strainData, setStrainData] = useState({
    sameStrainGenome: true,
    sameStrainTF: true,
    organismTFBindingSites: "",
    organismReportedTF: "",
    promoterInfo: false,
    expressionInfo: false,
  });

  // Step 3 – tècniques experimentals seleccionades
  const [techniques, setTechniques] = useState([]);

  // Step 4 – sites reportats + genomes carregats (seqüència + genes)
  const [step4Data, setStep4Data] = useState(null);
  const [genomes, setGenomes] = useState([]);

  // Step 5/6/7 – dades dels últims passos
  const [step5Data, setStep5Data] = useState(null);
  const [step6Data, setStep6Data] = useState(null);
  const [step7Data, setStep7Data] = useState(null);

  // Taxonomia calculada a partir de les accessions (Step 2)
  const [taxonomyData, setTaxonomyData] = useState({ byAccession: {} });

  // Anar al següent pas
  const goToNextStep = () => setCurrentStep((s) => s + 1);

  // Anar a qualsevol pas enrere
  const goToStep = (n) => setCurrentStep(n);

  return (
    <CurationContext.Provider
      value={{
        // navegació
        currentStep,
        goToStep,
        goToNextStep,

        // step 1
        publication,
        setPublication,

        // step 2
        tf,
        setTf,
        genomeList,
        setGenomeList,
        uniprotList,
        setUniprotList,
        refseqList,
        setRefseqList,
        strainData,
        setStrainData,
        taxonomyData,
        setTaxonomyData,

        // step 3
        techniques,
        setTechniques,

        // step 4
        step4Data,
        setStep4Data,
        genomes,
        setGenomes,

        // step 5,6,7
        step5Data,
        setStep5Data,
        step6Data,
        setStep6Data,
        step7Data,
        setStep7Data,
      }}
    >
      {children}
    </CurationContext.Provider>
  );
}
