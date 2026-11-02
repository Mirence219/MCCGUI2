.pragma library

const iconProxy = "https://favicon.im"

class Url {
    constructor(rawUrl) {
        this._raw = rawUrl ?? "";
        this._protocol = "";
        this._host = "";
        this._port = "";
        this.parse();
        if (!this.isValid()) {
            throw new Error("Invalid URL!");
        }
    }

    parse() {
        if (!this._raw) return;
        let s = this._raw.trim();
        // 提取protocol
        const protoMatch = s.match(/^(https?):\/\//);
        if (protoMatch) {
            this._protocol = protoMatch[1];
            s = s.slice(protoMatch[0].length);
        } else {
            this._protocol = "";
        }
        // 提取 host / port
        const hostPortMatch = s.match(/^([^\/:]+)(?::(\d+))?/);
        if (hostPortMatch) {
            this._host = hostPortMatch[1];
            this._port = hostPortMatch[2] ?? "";
        } else {
            this._host = "";
            this._port = "";
        }
    }

    isValid() {
        // host检查
        const hostReg = /^[a-zA-Z0-9.-]+$/;
        if (this._host !== "" && !hostReg.test(this._host)) return false;

        // protocol检查
        if (this._protocol !== "" && !["http", "https"].includes(this._protocol)) {
            return false;
        }

        // 端口检查
        if (this._port !== "" && !/^\d+$/.test(this._port)) {
            return false;
        }

        return true;
    }

    isEmpty() {
        return this._host === "";
    }

    toHttp() {
        if (!this.url) return "";
        return "http://" + this._host + this._port;
    }

    toHttps() {
        if (!this.url) return "";
        let u = this.url.replace(/^https?:\/\//, "");
        return "https://" + this._host + this._port;
    }

    get host() {
        return this._host;
    }

    get port() {
        return this._port;
    }

    get protocol() {
        return this._protocol;
    }

    get url() {
        return this._protocol + "://" + this._host;
    }

    get icon() {
        return iconProxy + "/" + this._host;
    }
}
