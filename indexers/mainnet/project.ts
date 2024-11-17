import {
  SubstrateDatasourceKind,
  SubstrateHandlerKind,
  SubstrateProject,
} from "@subql/types";

// Can expand the Datasource processor types via the genreic param
const project: SubstrateProject = {
  specVersion: "1.0.0",
  version: "0.0.1",
  name: "ai3-api-indexer-mainnet",
  description: "AI3 API - Indexer Mainnet",
  repository: "https://github.com/marc-aurele-besner/ai3-api",
  runner: {
    node: {
      name: "@subql/node",
      version: ">=5.2.9",
    },
    query: {
      name: "@subql/query",
      version: "*",
    },
  },
  schema: {
    file: "./schema.graphql",
  },
  network: {
    /* The genesis hash of the network (hash of block 0) */
    chainId:
      "0x66455a580aabff303720aa83adbe6c44502922251c03ba73686d5245da9e21bd",
    /**
     * These endpoint(s) should be public non-pruned archive node
     * We recommend providing more than one endpoint for improved reliability, performance, and uptime
     * Public nodes may be rate limited, which can affect indexing speed
     * When developing your project we suggest getting a private API key
     * If you use a rate limited endpoint, adjust the --batch-size and --workers parameters
     * These settings can be found in your docker-compose.yaml, they will slow indexing but prevent your project being rate limited
     */
    endpoint: "ws://caddy:8000",
    // @ts-ignore
    types: {
      Solution: {
        public_key: "AccountId32",
        reward_address: "AccountId32",
      },
      SubPreDigest: {
        slot: "u64",
        solution: "Solution",
      },
    },
  },
  dataSources: [
    {
      kind: SubstrateDatasourceKind.Runtime,
      startBlock: 1,
      mapping: {
        file: "./dist/index.js",
        handlers: [
          {
            kind: SubstrateHandlerKind.Block,
            handler: "handleBlock",
          },
        ],
      },
    },
    {
      kind: SubstrateDatasourceKind.Runtime,
      startBlock: 1,
      mapping: {
        file: "./dist/index.js",
        handlers: [
          {
            kind: SubstrateHandlerKind.Call,
            handler: "handleCall",
          },
        ],
      },
    },
    {
      kind: SubstrateDatasourceKind.Runtime,
      startBlock: 1,
      mapping: {
        file: "./dist/index.js",
        handlers: [
          {
            kind: SubstrateHandlerKind.Event,
            handler: "handleEvent",
          },
        ],
      },
    },
  ],
};

// Must set default to the project instance
export default project;
