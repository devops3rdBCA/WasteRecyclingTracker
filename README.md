# Waste Recycling Tracker Frontend

This is the frontend for a small waste recycling tracking system built with React and Vite.

The app has three main parts:

- a login screen
- a family dashboard where waste entries can be added, edited, and removed
- a center dashboard and statistics page for reviewing submissions

It is set up to work with a backend API, but it can also keep working without one by falling back to localStorage in the browser. That makes it useful for demos, testing, or showing the UI without needing the full backend running.

## What the app does

Families can submit waste records by type and quantity. Those entries can then be reviewed by the recycling center, where the status can be updated as the waste moves through the process. The statistics page gives a simple summary of total entries, total quantity, families involved, waste-type totals, and status-based breakdowns.

## Built with

- React 18
- Vite 5
- React Router
- Axios
- Bootstrap 5
- Material UI

## Running the project locally

Make sure Node.js 18 or newer is installed.

Install dependencies:

```bash
npm install
```

Start the development server:

```bash
npm run dev
```

Then open:

```text
http://localhost:5173
```

## Available scripts

- npm run dev starts the app in development mode
- npm run build creates a production build in the dist folder
- npm run preview serves the production build locally

## Backend configuration

If you have a backend running, you can point the frontend to it with this environment variable:

```env
VITE_API_URL=http://localhost:8081
```

If that variable is not set, the frontend uses http://localhost:8081 by default.

The app first tries backend routes under /api. If the backend is unavailable for the main entry and statistics flows, the frontend falls back to localStorage so the basic features still work.

The local keys used are:

- wasteEntries
- wasteEntriesNextId

## Main pages

- / for login
- /family for the family dashboard
- /center for the recycling center dashboard
- /statistics for the statistics dashboard

## Docker

To build the image:

```bash
docker build -t waste-recycling-frontend .
```

To run it:

```bash
docker run -p 3000:3000 waste-recycling-frontend
```

Then open:

```text
http://localhost:3000
```

## Before uploading to GitHub

This folder is ready to push, but a few basics are worth checking:

- keep node_modules out of the repository
- do not commit secret or machine-specific environment files
- include package-lock.json so installs stay consistent
- make sure .gitignore covers local and build artifacts

## Final note

This project does not currently include a license file. If you plan to make the repository public, add one before sharing it.