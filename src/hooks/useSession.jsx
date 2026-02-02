import { useEffect, useState } from "react";

const vercelUrl = "https://recollectf.vercel.app";

// En local (Vite), import.meta.env.DEV === true
const DISABLE_AUTH =
  import.meta.env.VITE_DISABLE_AUTH === "true" || import.meta.env.DEV;

export function useSession() {
  const [user, setUser] = useState(null);
  const [userStatus, setUserStatus] = useState(0); // 0: logged out, 1: logged in, 2: collaborator
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // En local: no hacemos llamadas a Vercel (evitas CORS y 401)
    if (DISABLE_AUTH) {
      setUser("Local Dev");
      setUserStatus(2); // dale permisos de colaborador para probar todo
      setLoading(false);
      return;
    }

    const getUser = async () => {
      try {
        const userRes = await fetch(`${vercelUrl}/api/functions/get-user`, {
          credentials: "include",
        });
        if (!userRes.ok) throw new Error("Not logged in");

        const userData = await userRes.json();
        setUser(userData.username);

        const collabRes = await fetch(
          `${vercelUrl}/api/functions/check-collaborator`,
          { credentials: "include" }
        );
        if (!collabRes.ok) throw new Error("Not logged in");

        const collabData = await collabRes.json();
        setUserStatus(collabData.isCollaborator ? 2 : 1);
      } catch {
        setUser(null);
        setUserStatus(0);
      } finally {
        setLoading(false);
      }
    };

    getUser();
  }, []);

  return { user, userStatus, loading };
}
