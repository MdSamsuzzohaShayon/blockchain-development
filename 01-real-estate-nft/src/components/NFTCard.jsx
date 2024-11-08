// NFTCard.js
import { Card, CardContent, CardMedia, Typography, Button, Box } from '@mui/material';

const NFTCard = ({ title, description, imageUrl, price, address }) => {
  return (
    <Card
      sx={{
        maxWidth: 345,
        m: 2,
        borderRadius: 2,
        boxShadow: 3,
        transition: "transform 0.3s",
        '&:hover': {
          transform: "scale(1.05)",
        },
      }}
    >
      <CardMedia
        component="img"
        height="200"
        image={imageUrl}
        alt={title}
      />
      <CardContent>
        <Typography variant="h6" component="div" gutterBottom>
          {title}
        </Typography>
        <Typography variant="body2" color="text.secondary">
          {description}
        </Typography>
        <Typography variant="body2" color="text.secondary">
          {address}
        </Typography>
        <Typography variant="h6" sx={{ mt: 1, fontWeight: 'bold' }}>
          {price} ETH
        </Typography>
        <Button variant="contained" color="primary" fullWidth sx={{ mt: 2 }}>
          Buy Now
        </Button>
      </CardContent>
    </Card>
  );
};

export default NFTCard;
