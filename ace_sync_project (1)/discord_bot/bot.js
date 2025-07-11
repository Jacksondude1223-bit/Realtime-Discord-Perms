
require('dotenv').config();
const { Client, GatewayIntentBits } = require('discord.js');
const axios = require('axios');

const client = new Client({
  intents: [GatewayIntentBits.Guilds, GatewayIntentBits.GuildMembers],
});

const FIVEM_API_URL = 'http://localhost:30120/role-sync';

client.once('ready', () => {
  console.log(`✅ Logged in as ${client.user.tag}`);
});

client.on('guildMemberUpdate', async (oldMember, newMember) => {
  const addedRoles = newMember.roles.cache.filter(role => !oldMember.roles.cache.has(role.id));
  if (addedRoles.size === 0) return;

  const discordId = newMember.id;
  const roleNames = newMember.roles.cache.map(r => r.name);

  try {
    await axios.post(FIVEM_API_URL, {
      discord_id: discordId,
      roles: roleNames
    });
    console.log(`✅ Synced ${roleNames.length} roles for ${newMember.user.tag}`);
  } catch (error) {
    console.error('❌ Failed to sync roles to FiveM:', error.message);
  }
});

client.login(process.env.DISCORD_TOKEN);
