import { VercelRequest, VercelResponse } from '@vercel/node';
import { verify } from 'jsonwebtoken';
import axios from 'axios';
import cookie from 'cookie';

const JWT_SECRET = process.env.JWT_SECRET!;
const BOT_TOKEN = process.env.BOT_TOKEN!;
const REPO_OWNER = 'Milegoo';
const REPO_NAME = 'CollecTF';
const WORKFLOW_FILE_NAME = 'deploy.yml';

export default async function handler(req: VercelRequest, res: VercelResponse) {
    if (req.method !== 'POST') {
        return res.status(405).json({ error: 'Only POST allowed' });
    }

    //1 - Verify JWT token from cookies
    const cookies = cookie.parse(req.headers.cookie || '');
    const token = cookies['session_token'];
    if (!token) return res.status(401).json({ error: 'No session token' });

    let payload;
    try {
        payload = verify(token, JWT_SECRET) as any;
    } catch {
        return res.status(401).json({ error: 'Invalid session' });
    }

    //2 - Get SQL query

    const { inputs } = req.body;

    //3 - Dispatch GitHub workflow via GitHub API

    try {
        const response = await axios.post(
            `https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/workflows/${WORKFLOW_FILE_NAME}/dispatches`,
            {
                ref: 'main',
                inputs, //Maximum number of properties is 10
            },
            {
                headers: {
                Authorization: `Bearer ${BOT_TOKEN}`,
                Accept: 'application/vnd.github+json',
                },
            }
        );

        return res.status(200).json({ message: 'Workflow dispatched' });
    } catch (err) {
        console.error('Error dispatching:', err.response?.data || err.message);
        return res.status(500).json({ error: 'Error dispatching workflow' });
    }
}
