import React from 'react';
import { TextField, Button, Typography, Box, Stack } from '@mui/material';
import { Contract } from 'ethers';

interface IDisplayProps {
  account: string;
  contract: Contract | null;
}

function Display({ account, contract }: IDisplayProps) {
  const handleDisplayImages = async (e: React.SyntheticEvent) => {
    e.preventDefault();
    if (!contract) return;

    try {
      
      const imgList = await contract.display(account);
      console.log({imgList});
    } catch (error) {
      console.log(error);
      
    }
    
  }
  return (
    <Box
      sx={{
        maxWidth: 600,
        margin: '0 auto',
        padding: 3,
        boxShadow: 3,
        borderRadius: 2,
        bgcolor: 'background.paper',
      }}
    >
      {/* Display Data */}
      <Typography variant="h6" gutterBottom>
        Image List
      </Typography>

      {/* Form */}
      <form action="" method="post">
        <Stack spacing={2}>
          {/* Text Input for Address */}
          <TextField
            fullWidth
            label="Enter Address"
            variant="outlined"
            placeholder="Enter the address to get images"
            className="address"
          />

          {/* Submit Button */}
          <Button
            variant="contained"
            color="primary"
            type="submit"
            className="align-center"
            fullWidth
            onClick={handleDisplayImages}
          >
            Get Images
          </Button>
        </Stack>
      </form>
    </Box>
  );
}

export default Display;
