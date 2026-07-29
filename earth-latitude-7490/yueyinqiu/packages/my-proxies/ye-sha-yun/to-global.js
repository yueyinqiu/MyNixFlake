function main(config, log) {
    config["mode"] = "global";
    config["proxy-groups"] = [config["proxy-groups"][0]];
    config["rules"] = [];
    return config;
}