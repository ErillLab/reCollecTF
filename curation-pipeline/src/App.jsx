//Component principal que mostra per pantalla el necessari segons on estem.

import { useCuration } from "./context/CurationContext";
import StepNavigation from "./components/ui/StepNavigation"; //Component que pinta la barra dels passos
import Step1Publicacio from "./components/steps/Step1Publication";
import Step2GenomeTF from "./components/steps/Step2GenomeTF";
import Step3ExperimentalMethods from "./components/steps/Step3ExperimentalMethods";
import SummaryPanel from "./components/ui/SummaryPanel";
import Step4ReportedSites from "./components/steps/Step4ReportedSites";
import Step5SiteAnnotation from "./components/steps/Step5SiteAnnotation";
import Step6GeneRegulation from "./components/steps/Step6GeneRegulation";
import Step7CurationInfo from "./components/steps/Step7CurationInfo";


export default function App() {
  const { currentStep } = useCuration();

  return (
    <div className="max-w-6xl mx-auto p-8">
      <h1 className="text-4xl font-bold mb-6 text-accent">CURATION PIPELINE</h1>

      <div className="flex gap-6">
        
        {/*Steps (zona esquerra*/}
        <div className="flex-1">
          <StepNavigation />

          {currentStep === 1 && <Step1Publicacio />}
          {currentStep === 2 && <Step2GenomeTF />}
          {currentStep === 3 && <Step3ExperimentalMethods />}
          {currentStep === 4 && <Step4ReportedSites />}
          {currentStep === 5 && <Step5SiteAnnotation />}
          {currentStep === 6 && <Step6GeneRegulation />}
          {currentStep === 7 && <Step7CurationInfo />}
        </div>

        {/*Resum (zona dreta*/}
        <SummaryPanel />
      </div>
    </div>
  );
}

