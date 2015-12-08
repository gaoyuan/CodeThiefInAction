> This is an auto-generated error report for the [Wurst Client](https://www.wurst-client.tk).

# Description
An error occurred while processing events.
Event type: UpdateEvent

# Stacktrace
```
java.lang.NullPointerException
	at tk.wurst_client.utils.BuildUtils.advancedInstantBuild(BuildUtils.java:764)
	at tk.wurst_client.mods.InstantBunkerMod.onUpdate(InstantBunkerMod.java:326)
	at tk.wurst_client.events.EventManager.fireUpdate(EventManager.java:124)
	at tk.wurst_client.events.EventManager.fireEvent(EventManager.java:36)
	at net.minecraft.client.entity.EntityPlayerSP.onUpdate(EntityPlayerSP.java:129)
	at net.minecraft.world.World.updateEntityWithOptionalForce(World.java:1884)
	at net.minecraft.world.World.updateEntity(World.java:1853)
	at net.minecraft.world.World.updateEntities(World.java:1702)
	at net.minecraft.client.Minecraft.runTick(Minecraft.java:2303)
	at net.minecraft.client.Minecraft.runGameLoop(Minecraft.java:1198)
	at net.minecraft.client.Minecraft.run(Minecraft.java:378)
	at net.minecraft.client.main.Main.main(Main.java:129)

```

# System details
- OS: Windows 8.1 (amd64)
- Java version: 1.8.0_25 (Oracle Corporation)
- Wurst version: 2.11.2 (latest: 2.11.2)
- Timestamp: 2015.12.08-04:22:59
