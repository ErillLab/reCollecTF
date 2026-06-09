import { HashRouter, Routes, Route } from "react-router-dom";
import "./index.css";
import Layout from "./pages/Layout";
import HomePage from "./pages/HomePage";
import SearchPage from "./pages/Search/SearchPage";
import ProtectedRoute from "./components/ProtectedRoute";
import { useUser } from "@/contexts/UserContext";
import CurationPipeline from "./pages/CurationPipeline.jsx";
import { CurationProvider } from "./contexts/CurationContext.jsx";
import DetailedView from "./components/uniprot-tf-queries/detail/DetailedView.jsx";

function AppRoutes() {
  const { userStatus } = useUser();
  return (
    <HashRouter>
      <Routes>
        <Route path="/" element={<Layout />}>
          <Route index element={<HomePage />} />
          <Route path="Search/:step?" element={<SearchPage />} />
          <Route
          path="curation-pipeline/*"
          element={
            <CurationProvider>
              <CurationPipeline />
            </CurationProvider>
            }
          />
        </Route>
      </Routes>
    </HashRouter>
  );
}

export default AppRoutes;
