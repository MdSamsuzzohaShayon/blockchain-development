import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

// https://hardhat.org/hardhat-runner/docs/guides/deploying
// Define the Upload module
const UploadModule = buildModule("UploadModule", (m) => {
  // Deploy the Upload contract with no constructor parameters
  const upload = m.contract("Upload", []);

  return { upload };
});

export default UploadModule;