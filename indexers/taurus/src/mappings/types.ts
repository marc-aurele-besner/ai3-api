export type ExtrinsicPrimitive = {
  callIndex: string;
  args: any;
};

export type ExtrinsicHuman = ExtrinsicPrimitive & {
  method: string;
  section: string;
};

export type EventPrimitive = {
  index: string;
  data: any;
};

export type EventHuman = EventPrimitive & {
  method: string;
  section: string;
};

export type LogValue = {
  data: any;
  engine?: string;
};

export type Cid = string | undefined;
export type ModifiedArgs = string | undefined;

export type ParsedArgs = {
  cid: Cid;
  modifiedArgs: ModifiedArgs;
  links: string[];
};
