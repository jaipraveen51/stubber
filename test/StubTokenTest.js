import assertRevert from "zeppelin-solidity/test/helpers/assertRevert";

const StubToken = artifacts.require("StubToken");

contract("Stub token", accounts => {
  it("Should make first account an owner", async () => {
    let instance = await StubToken.deployed();
    let owner = await instance.owner();
    assert.equal(owner, accounts[0]);
  });

  describe("mint", () => {
    it("creates token with specified eventId and price", async () => {
      let instance = await StubToken.deployed();
      let owner = await instance.owner();

      let token = await instance.mint(0, 1);

      let tokens = await instance.tokenOfOwnerByIndex(owner, 0);
      let ticket = await instance.getTicket(tokens);
      assert.deepEqual(ticket, [0, 1]);
    });

    it("allows to mint only to owner", async () => {
      let instance = await StubToken.deployed();
      let other = accounts[1];

      await instance.transferOwnership(other);
      await assertRevert(instance.mint(0, 1));
    });
  });
});
