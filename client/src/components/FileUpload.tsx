import React, { useState } from 'react';
import { Button, Typography, Box, Stack } from '@mui/material';
import CloudUploadIcon from '@mui/icons-material/CloudUpload';
import { Contract } from 'ethers';
import { JsonRpcSigner } from 'ethers';

interface IFileUploadProps {
    account: string;
    contract: Contract | null;
}

function FileUpload({ account, contract }: IFileUploadProps) {
    const [fileName, setFileName] = useState('No file selected');
    const [uploadedFile, setUploadedFile] = useState<File | null>(null);

    // handle image - To Upload the image on IPFS
    const handleSubmit = async (e: React.SyntheticEvent) => {
        e.preventDefault();
        if (!uploadedFile) return;

        try {
            // Upload file to Pinata
        } catch (error) {
            console.log(error);

        }


    }

    // Retrieve the image
    const handleFileChange = (e: React.SyntheticEvent) => {
        e.preventDefault();
        const inputEl = e.target as HTMLInputElement;
        if (inputEl && inputEl.files && inputEl.files[0]) {
            const newFile = inputEl.files[0];
            const fileReader = new FileReader();
            fileReader.readAsArrayBuffer(newFile);
            fileReader.onloadend = () => {
                setUploadedFile(newFile);
            }
            setFileName(newFile.name);
            // Here you can add additional logic to automatically submit the file
            // after selection if you want.
            console.log('File selected:', newFile);
        } else {
            setFileName('No file selected');
        }
    };

    return (
        <Box
            sx={{
                maxWidth: 600,
                margin: '0 auto',
                padding: 2,
                boxShadow: 3,
                borderRadius: 2,
                bgcolor: 'background.paper',
            }}
        >
            <form onSubmit={handleSubmit}>
                <Stack spacing={2}>

                    {/* File upload button */}
                    <Button
                        variant="contained"
                        component="label"
                        startIcon={<CloudUploadIcon />}
                        fullWidth
                        color="primary"
                    >
                        Upload File
                        <input
                            type="file"
                            hidden
                            id="file-upload"
                            onChange={handleFileChange}
                        />
                    </Button>

                    {/* Display selected file name */}
                    <Typography variant="body2" color="textSecondary">
                        Selected file: {fileName}
                    </Typography>

                </Stack>
            </form>
        </Box>
    );
}

export default FileUpload;
