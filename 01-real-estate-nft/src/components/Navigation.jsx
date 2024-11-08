import { useState } from 'react';
import { AppBar, Toolbar, Typography, IconButton, Button, Drawer, List, ListItem, ListItemIcon, ListItemText, Box } from '@mui/material';
import MenuIcon from '@mui/icons-material/Menu';
import HomeIcon from '@mui/icons-material/Home';
import AttachMoneyIcon from '@mui/icons-material/AttachMoney';
import BusinessIcon from '@mui/icons-material/Business';
import AccountBalanceWalletIcon from '@mui/icons-material/AccountBalanceWallet';
import logo from '../assets/logo.svg';

const Navigation = ({ account, setAccount }) => {
  const [isDrawerOpen, setIsDrawerOpen] = useState(false);

  const connectHandler = async () => {
    if (window.ethereum) {
      const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
      setAccount(accounts[0]);
    } else {
      alert("Please install MetaMask to connect your wallet.");
    }
  };

  const menuItems = [
    { text: 'Buy', icon: <HomeIcon /> },
    { text: 'Rent', icon: <AttachMoneyIcon /> },
    { text: 'Sell', icon: <BusinessIcon /> }
  ];

  return (
    <AppBar position="static" sx={{ backgroundColor: '#1c1c1c' }}>
      <Toolbar>
        {/* Logo and Title */}
        <Box display="flex" alignItems="center" flexGrow={1}>
          <img src={logo} alt="RealEstate NFT" style={{ height: '40px', marginRight: '10px' }} />
          <Typography variant="h6" component="div">
            RealEstate NFT
          </Typography>
        </Box>

        {/* Desktop Menu */}
        <Box sx={{ display: { xs: 'none', md: 'flex' } }}>
          {menuItems.map((item) => (
            <Button key={item.text} color="inherit" startIcon={item.icon}>
              {item.text}
            </Button>
          ))}
        </Box>

        {/* Wallet Connection Button */}
        {account ? (
          <Button
            color="inherit"
            startIcon={<AccountBalanceWalletIcon />}
          >
            {account.slice(0, 6) + '...' + account.slice(-4)}
          </Button>
        ) : (
          <Button
            color="inherit"
            startIcon={<AccountBalanceWalletIcon />}
            onClick={connectHandler}
          >
            Connect Wallet
          </Button>
        )}

        {/* Mobile Menu Icon */}
        <IconButton
          edge="end"
          color="inherit"
          aria-label="menu"
          sx={{ display: { xs: 'flex', md: 'none' } }}
          onClick={() => setIsDrawerOpen(true)}
        >
          <MenuIcon />
        </IconButton>
      </Toolbar>

      {/* Mobile Drawer */}
      <Drawer
        anchor="right"
        open={isDrawerOpen}
        onClose={() => setIsDrawerOpen(false)}
        sx={{ '& .MuiDrawer-paper': { backgroundColor: '#333', color: '#fff' } }}
      >
        <List>
          {menuItems.map((item) => (
            <ListItem button key={item.text}>
              <ListItemIcon sx={{ color: '#fff' }}>{item.icon}</ListItemIcon>
              <ListItemText primary={item.text} />
            </ListItem>
          ))}
          <ListItem button onClick={connectHandler}>
            <ListItemIcon sx={{ color: '#fff' }}>
              <AccountBalanceWalletIcon />
            </ListItemIcon>
            <ListItemText primary={account ? `Connected: ${account.slice(0, 6) + '...' + account.slice(-4)}` : "Connect Wallet"} />
          </ListItem>
        </List>
      </Drawer>
    </AppBar>
  );
};

export default Navigation;
