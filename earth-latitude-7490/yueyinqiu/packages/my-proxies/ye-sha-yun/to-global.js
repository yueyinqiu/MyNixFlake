function main(config, log) {
    config["mode"] = "global";
    config["proxy-groups"] = [
        config["proxy-groups"][1]    // url test
    ];
    config["rules"] = [];
    return config;
}