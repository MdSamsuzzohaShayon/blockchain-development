import React from 'react';
import { Box, Typography, Button, Modal as MUIModal } from '@mui/material';

// Styling for the Modal box
const style = {
  position: 'absolute',
  top: '50%',
  left: '50%',
  transform: 'translate(-50%, -50%)',
  width: 400,
  bgcolor: 'background.paper',
  boxShadow: 24,
  p: 4,
  borderRadius: '8px',
};

interface ModalProps {
  open: boolean;
  onClose: () => void;
  title: string;
  content: string;
  onConfirm?: () => void;
  confirmText?: string;
  cancelText?: string;
}

const Modal: React.FC<ModalProps> = ({
  open,
  onClose,
  title,
  content,
  onConfirm,
  confirmText = 'Confirm',
  cancelText = 'Cancel',
}) => {
  return (
    <MUIModal
      open={open}
      onClose={onClose}
      aria-labelledby="modal-title"
      aria-describedby="modal-description"
    >
      <Box sx={style}>
        {/* Modal Title */}
        <Typography id="modal-title" variant="h6" component="h2" sx={{ mb: 2, fontWeight: 'bold' }}>
          {title}
        </Typography>

        {/* Modal Content */}
        <Typography id="modal-description" sx={{ mb: 4 }}>
          {content}
        </Typography>

        {/* Modal Actions (Buttons) */}
        <Box display="flex" justifyContent="flex-end" gap={2}>
          <Button variant="outlined" color="secondary" onClick={onClose}>
            {cancelText}
          </Button>
          {onConfirm && (
            <Button variant="contained" color="primary" onClick={onConfirm}>
              {confirmText}
            </Button>
          )}
        </Box>
      </Box>
    </MUIModal>
  );
};

export default Modal;
