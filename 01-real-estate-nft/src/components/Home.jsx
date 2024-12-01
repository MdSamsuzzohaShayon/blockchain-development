import React, { forwardRef, useEffect, useState } from 'react';
import { Box, Button, Typography, Divider, List, ListItem, ListItemText, Grid2, IconButton } from '@mui/material';
import CloseIcon from '@mui/icons-material/Close';


const modalStyle = {
    position: 'absolute',
    top: '50%',
    left: '50%',
    transform: 'translate(-50%, -50%)',
    width: { xs: '95%', sm: '80%', md: 600 },
    bgcolor: 'background.paper',
    boxShadow: '0 8px 16px rgba(0, 0, 0, 0.1)',
    borderRadius: '16px',
    overflow: 'auto',
    maxHeight: '90vh',
    p: 3,
};

const imageStyle = {
    width: '100%',
    borderRadius: '12px',
    objectFit: 'cover',
    maxHeight: '240px',
};

const actionButtonStyle = {
    textTransform: 'none',
    borderRadius: '8px',
    py: 1.5,
    px: 3,
    fontSize: '1rem',
};

/*
Order is:
    buyer -> ionspector -> lender -> seller
*/
const Home = forwardRef(({ account, selectedHome, provider, escrow, onClose }, ref) => {
    const [hasBought, setHasBought] = useState(false);
    const [hasLended, setHasLended] = useState(false);
    const [hasInspected, setHasInspected] = useState(false);
    const [hasSold, setHasSold] = useState(false);

    const [buyer, setBuyer] = useState(null);
    const [lender, setLender] = useState(null);
    const [inspector, setInspector] = useState(null);
    const [seller, setSeller] = useState(null);


    const [owner, setOwner] = useState(null);

    const buyHandler = async (e) => {
        e.preventDefault();
        const escrowAmount = await escrow.escrowAmount(selectedHome.id);
        const signer = await provider.getSigner(); // Connected account


        // Buyer deposit earnest 
        const earnestTransaction = await escrow.connect(signer).depositEarnest(selectedHome.id, { value: escrowAmount });
        await earnestTransaction.wait();

        // Buyer approves 
        const signerTransaction = await escrow.connect(signer).approveSale(selectedHome.id);
        await signerTransaction.wait();

    }

    const inspectHandler = async (e) => {
        e.preventDefault();
        const signer = await provider.getSigner(); // Connected account

        const updateStatusTransaction = await escrow.connect(signer).updateInspectionStatus(selectedHome.id, true);
        await updateStatusTransaction.wait();
        setHasInspected(true);

    }


    const lendHandler = async (e) => {
        e.preventDefault();

        const signer = await provider.getSigner(); // Connected account

        // Lender approves...
        const transaction = await escrow.connect(signer).approveSale(selectedHome.id)
        await transaction.wait()

        const lendAmount = (await escrow.purchasePrice(selectedHome.id) - await escrow.escrowAmount(selectedHome.id));
        await signer.sendTransaction({ to: escrow.address, value: lendAmount.toString(), gasLimit: 60000 });

        setHasLended(true);
    }

    const sellHandler = async (e) => {
        e.preventDefault();
        const signer = await provider.getSigner(); // Connected account

        const saleTransaction = await escrow.connect(signer).approveSale(selectedHome.id);
        await saleTransaction.wait();

        const finalizeTransaction = await escrow.connect(signer).finalizeSale(selectedHome.id);
        await finalizeTransaction.wait();

        setHasSold(true);

    }

    const fetchDetails = async () => {
        const buyer = await escrow.buyer(selectedHome.id);
        setBuyer(buyer);

        const hasBought = await escrow.approval(selectedHome.id, buyer);
        setHasBought(hasBought);

        const seller = await escrow.seller();
        setSeller(seller);

        const hasSold = await escrow.approval(selectedHome.id, seller);
        setHasSold(hasSold);

        const lender = await escrow.lender();
        setLender(lender);

        const hasLended = await escrow.approval(selectedHome.id, lender);
        setHasLended(hasLended);

        const inspector = await escrow.inspector();
        setInspector(inspector);

        const hasInspected = await escrow.inspectionPassed(selectedHome.id);
        setHasInspected(hasInspected);
    }


    const fetchOwner = async () => {
        if (await escrow.isListed(selectedHome.id)) return;
        const owner = await escrow.buyer(selectedHome.id);
        setOwner(owner);
    }

    useEffect(() => {
        fetchDetails()
        fetchOwner();
    }, [fetchDetails, fetchOwner, account, hasSold]);

    console.log({ buyer, lender, inspector, seller, account });


    return (
        <Box sx={modalStyle} ref={ref} tabIndex="-1">
            {/* Close Button */}
            <IconButton
                onClick={onClose}
                sx={{
                    position: 'absolute',
                    top: 12,
                    right: 12,
                    color: 'grey.500',
                }}
            >
                <CloseIcon />
            </IconButton>

            <Grid2 container spacing={4} alignItems="center">
                {/* Image Section */}
                <Grid2 item xs={12} sm={5}>
                    <Box display="flex" justifyContent="center">
                        <img
                            src={selectedHome?.image}
                            alt={selectedHome?.name}
                            style={imageStyle}
                        />
                    </Box>
                </Grid2>

                {/* Details Section */}
                <Grid2 item xs={12} sm={7}>
                    <Typography variant="h5" sx={{ fontWeight: 'bold', mb: 1 }}>
                        {selectedHome?.name}
                    </Typography>
                    <Typography variant="body2" color="text.secondary" gutterBottom>
                        {selectedHome?.description}
                    </Typography>
                    <Typography variant="body2" color="text.secondary" gutterBottom>
                        Address: {selectedHome?.address}
                    </Typography>
                    <Typography variant="body2" color="text.secondary">
                        {selectedHome?.attributes[2]?.value} beds •{' '}
                        {selectedHome?.attributes[3]?.value} baths •{' '}
                        {selectedHome?.attributes[4]?.value} sqft
                    </Typography>
                    <Typography variant="h6" sx={{ fontWeight: 'bold', mt: 2 }}>
                        {selectedHome?.attributes[0]?.value} ETH
                    </Typography>

                    {/* Conditional Buttons */}
                    <Box sx={{ display: 'flex', flexDirection: 'column', gap: 2, mt: 3 }}>
                        {owner ? (
                            <Typography variant="body1">
                                Owned by{' '}
                                <strong>
                                    {owner.slice(0, 6)}...{owner.slice(-4)}
                                </strong>
                            </Typography>
                        ) : (
                            (() => {
                                const normalizedAccount = account?.toLowerCase();
                                const normalizedInspector = inspector?.toLowerCase();
                                const normalizedLender = lender?.toLowerCase();
                                const normalizedSeller = seller?.toLowerCase();

                                let actionButton;
                                switch (normalizedAccount) {
                                    case normalizedInspector:
                                        actionButton = (
                                            <Button
                                                onClick={inspectHandler}
                                                variant="contained"
                                                color="primary"
                                                sx={actionButtonStyle}
                                                disabled={hasInspected}
                                            >
                                                Approve Inspection
                                            </Button>
                                        );
                                        break;
                                    case normalizedLender:
                                        actionButton = (
                                            <Button
                                                onClick={lendHandler}
                                                variant="contained"
                                                color="primary"
                                                sx={actionButtonStyle}
                                                disabled={hasLended}
                                            >
                                                Approve & Lend
                                            </Button>
                                        );
                                        break;
                                    case normalizedSeller:
                                        actionButton = (
                                            <Button
                                                onClick={sellHandler}
                                                variant="contained"
                                                color="primary"
                                                sx={actionButtonStyle}
                                                disabled={hasSold}
                                            >
                                                Approve & Sell
                                            </Button>
                                        );
                                        break;
                                    default:
                                        actionButton = (
                                            <Button
                                                onClick={buyHandler}
                                                variant="contained"
                                                color="primary"
                                                sx={actionButtonStyle}
                                                disabled={hasBought}
                                            >
                                                Buy Now
                                            </Button>
                                        );
                                }
                                return actionButton;
                            })()
                        )}
                        <Button
                            variant="outlined"
                            color="primary"
                            sx={actionButtonStyle}
                            fullWidth
                        >
                            Contact Agent
                        </Button>
                    </Box>
                </Grid2>
            </Grid2>

            {/* Divider */}
            <Divider sx={{ my: 4 }} />

            {/* Facts & Features */}
            <Typography variant="h6" sx={{ fontWeight: 'bold', mb: 2 }}>
                Facts & Features
            </Typography>
            <List dense>
                {selectedHome?.attributes?.map((attribute, index) => (
                    <ListItem key={index}>
                        <ListItemText
                            primary={`${attribute.trait_type}: ${attribute.value}`}
                            primaryTypographyProps={{
                                variant: 'body2',
                                color: 'text.secondary',
                            }}
                        />
                    </ListItem>
                ))}
            </List>
        </Box>
    );
});

export default Home;
