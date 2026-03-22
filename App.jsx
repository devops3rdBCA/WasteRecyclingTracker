import React from 'react';
import { BrowserRouter, Routes, Route, Link } from 'react-router-dom';
import FamilyDashboard from './FamilyDashboard';
import CenterDashboard from './CenterDashboard';
import StatisticsDashboard from './StatisticsDashboard';


const Home = () => (
  <div style={{ textAlign: 'center', marginTop: '3rem' }}>
    <h1>Welcome to WasteRecyclingTracker</h1>
    <div style={{ margin: '2rem' }}>
      <Link to="/family"><button>Family Dashboard</button></Link>
      <Link to="/center" style={{ marginLeft: '1rem' }}><button>Center Dashboard</button></Link>
      <Link to="/statistics" style={{ marginLeft: '1rem' }}><button>Statistics Dashboard</button></Link>
    </div>
  </div>
);

const App = () => (
  <BrowserRouter>
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/family" element={<FamilyDashboard />} />
      <Route path="/center" element={<CenterDashboard />} />
      <Route path="/statistics" element={<StatisticsDashboard />} />
    </Routes>
  </BrowserRouter>
);

export default App;


