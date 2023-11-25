#!/usr/bin/env python3
from pyrogram.enums import ParseMode
from pyrogram.handlers import MessageHandler, EditedMessageHandler
from pyrogram.filters import command
from io import BytesIO

from bot import LOGGER, bot
from bot.helper.telegram_helper.message_utils import sendMessage, sendFile
from bot.helper.ext_utils.bot_utils import cmd_exec, new_task
from bot.helper.telegram_helper.filters import CustomFilters
from bot.helper.telegram_helper.bot_commands import BotCommands


@new_task
async def shell(_, message):
    cmd = message.text.split(maxsplit=1)
    if len(cmd) == 1:
        await sendMessage(message, 'No command to execute was given.')
        return
    cmd = cmd[1]
    stdout, stderr, _ = await cmd_exec(cmd, shell=True)
    reply = ''
    if stdout:
        reply += f"```STDOUT\n{stdout}\n```\n"
        LOGGER.info(f"Shell - {cmd}")
    if stderr:
        reply += f"```STDERR\n{stderr}\n```"
        LOGGER.error(f"Shell - {cmd}")
    if len(reply) > 3000:
        output = stdout if stdout else stderr
        with BytesIO(str.encode(output)) as out_file:
            out_file.name = "shell_output.txt"
            await sendFile(message, out_file)
        return
    if stdout or stderr:
        await sendMessage(message, reply, parse_mode=ParseMode.MARKDOWN)
    else:
        await sendMessage(message, 'No Reply')


bot.add_handler(MessageHandler(shell, filters=command(
    BotCommands.ShellCommand) & CustomFilters.sudo))
bot.add_handler(EditedMessageHandler(shell, filters=command(
    BotCommands.ShellCommand) & CustomFilters.sudo))
