//import { useNavigate } from "react-router-dom";
//import "./Login.css";
const loginUrl = "https://collectf.vercel.app/api/auth/login"; // to be changed in prod: "https://collectf.vercel.app/api/auth/login"https://localhost:3000/api/auth/login
const logoutUrl = "https://collectf.vercel.app/api/auth/logout"; // to be changed in prod: "https://collectf.vercel.app/api/auth/logout"https://localhost:3000/api/auth/logout

function LoginButton({ userStatus, user, loading }) {

    return (
      <>
        {loading && <div className="animate-pulse text-gray-500 font-semibold">Loading...</div>}
        {userStatus == 0 && !loading &&
          <a className="text-accent no-underline" href={loginUrl}>
            <button className="btn bg-green-600 hover:bg-green-900 flex items-center gap-2 text-black"><img src="/reCollecTF/assets/loginout.png" alt="Log in" className="w-6 h-6"></img>Log In</button>
          </a>
        }
        {(userStatus == 1 || userStatus == 2) && !loading &&
          <a className="text-accent no-underline" href={logoutUrl}>
            <button className="btn bg-red-700 hover:bg-red-900 flex items-center gap-2 text-black"><img src="/reCollecTF/assets/loginout.png" alt="Log out" className="w-6 h-6"></img>Log Out</button>
          </a>
        }
        {(userStatus == 1 || userStatus == 2) && user && !loading && <b>{user}</b>}
      </>
    );
  }

export default LoginButton;