//Mostra una barra amb els passos del pipeline

import { useCuration } from "../../context/CurationContext";

export default function StepNavigation() {
  const { currentStep, goToStep } = useCuration();

  const steps = ["Publication","Genome and TF information", "Experimental Methods","Reported Sites", "Site annotation", "Gene Regulation", "Curation information",];

  return (
    <div className="mb-8">
      <div className="flex gap-2 mb-4">
        {steps.map((label, index) => {
          const stepNumber = index + 1;
          return (
            <button
              key={index}
              className={`px-4 py-2 rounded-md 
                ${currentStep === stepNumber ? "bg-accent text-black" : "bg-surface text-gray-300"}
              `}
              disabled={stepNumber > currentStep}
              onClick={() => goToStep(stepNumber)}
            >
              Step {stepNumber}: {label}
            </button>
          );
        })}
      </div>
    </div>
  );
}
