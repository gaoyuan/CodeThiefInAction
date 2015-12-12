Installing Office 2016
======================

I don't know if anyone else has had the issue, but I can't download my free Desktop Office 2016 from 
UQ (the button just isn't there). Being me, I wasted several hours figuring out how to get it. So 
here it is for future reference and if someone else runs into the same problem:


For Mac
=======
You can just download the installer from the following link and run it:
http://officecdn.microsoft.com/pr/C1297A47-86C4-4C1F-97FA-950631F94777/OfficeMac/Microsoft_Office_2016_Installer.pkg


For Windows
===========
For Windows there's a much more complicated system to get the data off a CDN (to let you do network 
installs and everything). So first, you need to download the "Office 2016 Deployment Tool" 
(https://www.microsoft.com/en-us/download/details.aspx?id=49117). Then run this in an empty folder.
It'll create "setup.exe" and "configuration.xml". Now replace configuration.xml with the following:
  
  ```
  <Configuration>
    <Add Branch="Current" OfficeClientEdition="64">
      <Product ID="O365ProPlusRetail">
        <Language ID="en-us"/>
      </Product>
    </Add>
    <Updates Branch="Current" Enabled="TRUE"/>
    <Display AcceptEULA="TRUE" Level="Full"/>
  </Configuration>
  ```

To download the installer, open a terminal (Shift + Click the folder and choose "open command window 
here") and type "setup.exe /download" and it'll download the installers from the CDN. Finally run 
"setup.exe /configure" to install everything.


Activation
==========
Now, you have to activate Office. To do this, login with your firstname.lastname@uqconnect.edu.au 
email address (the password is not your UQ password, but the one you had to create for the new mail 
system). They then appear normally in Office365 and you can deactivate them if you want, etc.

Hope this saves someone a bit of trouble!

Aapeli V