import { useNavigate } from "react-router-dom";
import SearchButton from "./search/general/SearchButton";
import NewCurationButton from "./search/general/NewCurationButton";
import LoginButton from "./LoginButton";
import WriteButton from "./WriteButton";
import { useUser } from '@/contexts/UserContext';


const Header = () => {
    const navigate = useNavigate();
    // const { user, userStatus, loading } = useSession();

    const { user, userStatus, loading } = useUser();
    
    const handleLogoClick = () => {
        navigate("/");
    };

    return (
        <header className="flex justify-between items-center bg-surface px-8 py-4 border-b border-border">
            <h1 className="text-5xl font-bold text-accent cursor-pointer hover:text-text" onClick={handleLogoClick}>
                CollecTF
            </h1>

            <div className="flex items-center gap-4">
                {(userStatus == 2) && <WriteButton />}

                <SearchButton />
                <NewCurationButton />

                <LoginButton userStatus={userStatus} user={user} loading={loading}/>
            </div>
        </header>
    );
}

export default Header;