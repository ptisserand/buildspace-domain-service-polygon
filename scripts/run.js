const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const domainContractFactory = await hre.ethers.getContractFactory('Domains');
    const domainContract = await domainContractFactory.deploy();
    await domainContract.deployed();
    console.log("Contract deployed to:", domainContract.address);
    console.log("Contract deployed by:", owner.address);

    let txn = await domainContract.register("loki");
    await txn.wait();

    const domainOwner = await domainContract.getAddress("loki");
    console.log("Owner of domains: ", domainOwner);

    // trying to set a record from another account
    txn = await domainContract.connect(randomPerson).setRecord("loki", "It's mine now!");
    await txn.wait();
}

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();