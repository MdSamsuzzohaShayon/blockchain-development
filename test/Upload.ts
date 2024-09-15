import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";

describe("Upload", function () {
  // We define a fixture to reuse the same setup in every test.
  async function deployUploadFixture() {
    const [owner, otherUser, anotherUser] = await hre.ethers.getSigners();

    const Upload = await hre.ethers.getContractFactory("Upload");
    const upload = await Upload.deploy();

    return { upload, owner, otherUser, anotherUser };
  }

  describe("Deployment", function () {
    it("Should deploy the contract successfully", async function () {
      const { upload } = await loadFixture(deployUploadFixture);
      expect(upload.address).to.not.be.null;
    });
  });

  describe("Adding URLs", function () {
    it("Should allow users to add URLs", async function () {
      const { upload, owner } = await loadFixture(deployUploadFixture);
      const url = "https://example.com";

      await upload.add(owner.address, url);

      const urls = await upload.display(owner.address);
      expect(urls).to.include(url);
    });

    it("Should not allow viewing URLs without permission", async function () {
      const { upload, otherUser, owner } = await loadFixture(deployUploadFixture);
      const url = "https://example.com";

      await upload.add(owner.address, url);

      await expect(upload.connect(otherUser).display(owner.address)).to.be.revertedWith(
        "Upload__PermissionDenied"
      );
    });
  });

  describe("Permission Management", function () {
    it("Should allow the owner to grant access", async function () {
      const { upload, owner, otherUser } = await loadFixture(deployUploadFixture);

      await upload.allow(otherUser.address);

      const accessList = await upload.shareAccess();
      expect(accessList[0].user).to.equal(otherUser.address);
      expect(accessList[0].access).to.be.true;
    });

    it("Should allow the owner to revoke access", async function () {
      const { upload, owner, otherUser } = await loadFixture(deployUploadFixture);

      await upload.allow(otherUser.address);
      await upload.disallow(otherUser.address);

      const accessList = await upload.shareAccess();
      expect(accessList[0].user).to.equal(otherUser.address);
      expect(accessList[0].access).to.be.false;
    });

    it("Should allow users with access to view URLs", async function () {
      const { upload, owner, otherUser } = await loadFixture(deployUploadFixture);
      const url = "https://example.com";

      await upload.add(owner.address, url);
      await upload.allow(otherUser.address);

      const urls = await upload.connect(otherUser).display(owner.address);
      expect(urls).to.include(url);
    });

    it("Should revert if users without access try to view URLs", async function () {
      const { upload, owner, anotherUser } = await loadFixture(deployUploadFixture);
      const url = "https://example.com";

      await upload.add(owner.address, url);

      await expect(upload.connect(anotherUser).display(owner.address)).to.be.revertedWith(
        "Upload__PermissionDenied"
      );
    });
  });
});
