import { Navigate, useNavigate } from "react-router-dom";

const WriteButton = () => {

    const navigate = useNavigate();

    return (<button className="btn" onClick={ () => {navigate("/Write")}}>Write</button>)
}

export default WriteButton;