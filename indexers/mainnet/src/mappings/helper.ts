import { account, blockNumber } from "@autonomys/auto-consensus";
import { cidOfNode, cidToString, decodeNode } from "@autonomys/auto-dag-data";
import { ApiPromise, stringify } from "@autonomys/auto-utils";
import { Bytes } from "@polkadot/types";
import { compactStripLength } from "@polkadot/util";
import { SubstrateBlock } from "@subql/types";
import { Cid, ModifiedArgs, ParsedArgs } from "./types";
import { decodeLog, hexToUint8Array } from "./utils";

const DEFAULT_ACCOUNT_ID = "0x00";
const DEFAULT_CHAIN_HEAD_OFFSET = 10;

// Core Consensus Helper Functions

export const getBlockAuthor = (block: SubstrateBlock): string => {
  const { digest } = block.block.header;
  const preRuntimeRaw = digest.logs.find((digestI) => digestI.isPreRuntime);
  if (preRuntimeRaw) {
    const value = decodeLog(preRuntimeRaw.asPreRuntime);
    if (value) {
      api.registry.register({
        Solution: {
          public_key: "AccountId32",
          reward_address: "AccountId32",
        },
        SubPreDigest: {
          slot: "u64",
          solution: "Solution",
        },
      });
      const type = api.registry.createType("SubPreDigest", value.data);
      const publicKey = (type.toPrimitive() as any).solution.public_key;
      const rewardAddress = (type.toPrimitive() as any).solution.reward_address;
      return rewardAddress;
    }
  }
  return DEFAULT_ACCOUNT_ID;
};

export const parseDataToCid = (data: string): ParsedArgs => {
  let cid: Cid = undefined;
  let links: string[] = [];
  let modifiedArgs: ModifiedArgs = undefined;
  try {
    const buffer = Buffer.from(data, "hex");
    try {
      const [length, bytes] = compactStripLength(buffer);
      const isValidLength = length === bytes.length;
      const encoded = isValidLength
        ? Bytes.from(buffer)
        : hexToUint8Array(data);
      const node = decodeNode(encoded);
      cid = cidToString(cidOfNode(node));
    } catch (error) {
      const encoded = Bytes.from(buffer);
      const node = decodeNode(encoded);
      cid = cidToString(cidOfNode(node));
      links = node.Links.map((l) => cidToString(l.Hash));
    }
    modifiedArgs = stringify({ cid });
  } catch (error) {
    logger.error("Error decoding remark or seedHistory extrinsic");
    logger.error(error);
  }
  return { cid, modifiedArgs, links };
};

// Accounts Helper Functions

export const getAccountBalance = async (accountId: string) =>
  await account(api as any, accountId);

export const preventIndexingTooCloseToTheHeadOfTheChain = async (
  indexingBlockHeight: number | bigint
) => {
  if (!unsafeApi) throw new Error("Unsafe API not found");
  if (
    typeof indexingBlockHeight !== "number" &&
    typeof indexingBlockHeight !== "bigint"
  )
    throw new Error("Indexing block height must be a number or bigint");
  if (typeof indexingBlockHeight === "number")
    indexingBlockHeight = BigInt(indexingBlockHeight);

  const targetHeight = await blockNumber(unsafeApi as unknown as ApiPromise);

  if (indexingBlockHeight > BigInt(targetHeight - DEFAULT_CHAIN_HEAD_OFFSET))
    throw new Error("Indexing too close to the head of the chain, skipping...");
};
