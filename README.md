# MinecraftSkyboxTemplate

This is a template to add a custom skybox to vanilla Minecraft with shaders. It works by drawing the moon across the entire screen, this means that in the shader you have access to the phase of the moon, allowing you to have a different skybox for each one of them. Also, you have access to the moon's texture, so you can put some extra info in there as well.

Please note that this is a template, so actually adding a skybox to this will require shader coding, this repository just contains the setup for it because I find it a bit tedious to code.

The file in which you should code the skybox is `position_tex.fsh`, the code comments should guide you. It already contains an example that just renders the vanilla skybox.

Oh btw, because this renders the moon as the skybox, it will actually remove the moon, I guess you could put it back by just making it part of your skybox but oh well ¯\\\_(ツ)_/¯