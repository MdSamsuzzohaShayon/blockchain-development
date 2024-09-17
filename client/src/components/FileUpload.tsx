import React, { useState } from 'react';
import { Button, Typography, Box, Stack } from '@mui/material';
import CloudUploadIcon from '@mui/icons-material/CloudUpload';
import { Contract } from 'ethers';
import { JsonRpcSigner } from 'ethers';
import axios, { AxiosRequestConfig } from 'axios';

interface IFileUploadProps {
    account: string;
    provider: null | JsonRpcSigner;
    contract: Contract | null;
}

function FileUpload({ account, contract, provider }: IFileUploadProps) {
    const [fileName, setFileName] = useState('No file selected');
    const [uploadedFile, setUploadedFile] = useState<File | null>(null);

    // handle image - To Upload the image on IPFS
    const handleSubmit = async (e: React.SyntheticEvent) => {
        e.preventDefault();
        if (!uploadedFile) return;

        try {
            // Upload file to Pinata
            // https://docs.pinata.cloud/api-reference/endpoint/ipfs/pin-file-to-ipfs
            const formData = new FormData();
            formData.append("file", uploadedFile);

            const config: AxiosRequestConfig = {
                headers: {
                    Authorization: `Bearer ${import.meta.env.VITE_PINATA_API_KEY}`,
                    "Content-Type": "multipart/form-data"
                }
            };
            console.log({ config });

            const response = await axios.post("https://api.pinata.cloud/pinning/pinFileToIPFS", formData, config);
            // A public gateway URL
            // https://docs.pinata.cloud/web3/ipfs-101/what-are-cids#public-ipfs-gateway-url
            const imgHash = `https://gateway.pinata.cloud/ipfs/${response.data.IpfsHash}`;
            console.log({ response, imgHash });
            // "https://gateway.pinata.cloud/ipfs/QmcuQKX5tNapHPMUzRM7B7hDKBwX57ExBiLX1xhAdbr5bB"
            // "https://gateway.pinata.cloud/ipfs/QmYoGABjS15U2Yrxr5vxF62NxJCksZQvVBeeCfc1WFH51Q"
            if (contract && provider) {
                const nonce = await provider.getNonce();
                console.log(`Current nonce: ${nonce}`);
                const tx = await contract.add(account, imgHash, { nonce });
                await tx.wait();
                setFileName("No image selected!");
            }
            setUploadedFile(null);
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
                        Choose
                        <input type="file" hidden id="file-upload" onChange={handleFileChange} />
                    </Button>

                    {/* Display selected file name */}
                    <Typography variant="body2" color="textSecondary">
                        Selected file: {fileName}
                    </Typography>

                    {/* Submit button */}
                    <Button
                        variant="contained"
                        color="secondary"
                        fullWidth
                        type="submit"
                        disabled={!uploadedFile} // Disable submit if no file selected
                    >
                        Upload File
                    </Button>
                </Stack>
            </form>
        </Box>
    );
}

export default FileUpload;