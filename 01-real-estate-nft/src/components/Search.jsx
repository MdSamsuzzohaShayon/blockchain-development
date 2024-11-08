import { Box, Typography, TextField, InputAdornment } from '@mui/material';
import SearchIcon from '@mui/icons-material/Search';

const Search = () => {
  return (
    <Box
      component="header"
      sx={{
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        minHeight: '30vh',
        bgcolor: 'background.paper',
        p: 2,
      }}
    >
      <Typography
        variant="h4"
        component="h2"
        sx={{
          mb: 2,
          textAlign: 'center',
          fontWeight: 'bold',
          color: 'primary.main',
        }}
      >
        Search it. Explore it. Buy it.
      </Typography>
      
      <TextField
        variant="outlined"
        placeholder="Enter an address, neighborhood, city, or ZIP code"
        fullWidth
        sx={{
          maxWidth: { xs: '100%', sm: '80%', md: '60%', lg: '50%' },
          bgcolor: 'white',
          boxShadow: 3,
          borderRadius: 2,
          '& .MuiOutlinedInput-root': {
            '& fieldset': {
              borderColor: 'primary.main',
            },
            '&:hover fieldset': {
              borderColor: 'primary.dark',
            },
            '&.Mui-focused fieldset': {
              borderColor: 'primary.light',
            },
          },
        }}
        InputProps={{
          startAdornment: (
            <InputAdornment position="start">
              <SearchIcon color="primary" />
            </InputAdornment>
          ),
        }}
      />
    </Box>
  );
}

export default Search;
