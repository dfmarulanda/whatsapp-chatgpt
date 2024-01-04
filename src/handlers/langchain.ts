import { Message } from "whatsapp-web.js";
import * as cli from "../cli/ui";


// TODO add conversation ID to build a chat history
const handleMessageLangChain = async (message: Message, prompt: string) => {
	try {

		const start = Date.now();
		  
		console.log(message)

		const end = Date.now() - start;

		cli.print(`[GPT] Answer to ${message.from}: ${message}  | OpenAI request took ${end}ms)`);
		// Default: Text reply
	} catch (error: any) {
		console.error("An error occured", error);
		message.reply("An error occured, please contact the administrator. (" + error.message + ")");
	}
};

export { handleMessageLangChain };
