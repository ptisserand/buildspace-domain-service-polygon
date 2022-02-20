const main = async () => {
    const domainContractFactory = await hre.ethers.getContractFactory('Domains');
    const domainContract = await domainContractFactory.deploy("foobar");
    await domainContract.deployed();
    console.log("Contract deployed to:", domainContract.address);

    let txn = await domainContract.register("spams", {value: hre.ethers.utils.parseEther("0.1")});
    await txn.wait();
    console.log("Minted domain spams.foobar");

    txn = await domainContract.setRecord("spams", "Spams/Foo/Bar???");
    await txn.wait();
    console.log("Set record for spams.foobar");

    const address = await domainContract.getAddress("spams");
    console.log("Owner of domain spams", address);

    const balance = await hre.ethers.provider.getBalance(domainContract.address);
    console.log("Contract balance:", hre.ethers.utils.formatEther(balance));
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch(error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();
