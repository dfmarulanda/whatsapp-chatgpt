import { Message } from "whatsapp-web.js";
import * as cli from "../cli/ui";
import { fullChain } from "../database";


// TODO add conversation ID to build a chat history
const handleMessageLangChain = async (message: Message, prompt: string) => {
	try {

		const start = Date.now();
		  
		const output = await fullChain.invoke({
			question: prompt,
		  });

		console.log(output)

		const end = Date.now() - start;

		cli.print(`[GPT] Answer to ${message.from}: ${output}  | OpenAI request took ${end}ms)`);
		// Default: Text reply
		message.reply(String(output.content));
	} catch (error: any) {
		console.error("An error occured", error);
		message.reply("An error occured, please contact the administrator. (" + error.message + ")");
	}
};

export { handleMessageLangChain };
