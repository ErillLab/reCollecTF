//Cervell del pipeline. Guarda les dades a compartir entre components/steps. (Pas que s'està fent, publicació seleccionada...)

import { createContext, useContext, useState } from "react"; //Creem 3 eines de React

const CurationContext = createContext();

export function useCuration() {
  //Hook per a que desde tots els components puguem accedir a les dades de useCuration
  return useContext(CurationContext);
}

export function CurationProvider({ children }) {
  const [currentStep, setCurrentStep] = useState(1); //currentStep per a guardar el step en el que estem, al principi el 1

  const [publication, setPublication] = useState(null); //guardem la publication del step1, al principi null

  const [tf, setTf] = useState(null); //TF step2
  const [genomeList, setGenomeList] = useState([]); // llistes accession numbers
  const [uniprotList, setUniprotList] = useState([]);
  const [refseqList, setRefseqList] = useState([]);
  const [strainData, setStrainData] = useState({
    sameStrainGenome: true, //checkboxes
    sameStrainTF: true,
    organismTFBindingSites: "",
    organismReportedTF: "",
    promoterInfo: false,
    expressionInfo: false,
  });

  const [techniques, setTechniques] = useState([]); //Tècniques del Step3

  // STEP 4 – Reported sites
  const [step4Data, setStep4Data] = useState(null);
  const [genomes, setGenomes] = useState([]);


  // STEP 5 – Site annotation
  const [step5Data, setStep5Data] = useState(null);

  const [step6Data, setStep6Data] = useState(null);

  const [step7Data, setStep7Data] = useState(null);

  const [taxonomyData, setTaxonomyData] = useState({ byAccession: {} });

  const goToNextStep = () => setCurrentStep((s) => s + 1); //anar al següent pas
  const goToStep = (n) => setCurrentStep(n); //anar a qualsevol pas

  return (
    <CurationContext.Provider
      value={{
        currentStep,
        goToStep,
        goToNextStep,
        publication,
        setPublication,
        tf,
        setTf,
        techniques,
        setTechniques,
        genomeList,
        setGenomeList,
        uniprotList,
        setUniprotList,
        refseqList,
        setRefseqList,
        strainData,
        setStrainData,
        step4Data,
        setStep4Data,
        step5Data,
        setStep5Data,
        step6Data,
        setStep6Data,
        step7Data,
        setStep7Data,
        genomes, 
        setGenomes,
        taxonomyData,
        setTaxonomyData,
      }}
    >
      {children}
    </CurationContext.Provider>
  );
}
