Setup.Package
{
    vendor = "liflg.org",
    -- unique identifier, will be proposed as installdirectory SAMPLE: "fakk2"
    id = "",
    -- full name of the game, will be used during setup SAMPLE: "Heavy Metal: FAKK2"
    description = "",
    -- version of the game SAMPLE: "1.02-english"
    version = "",
    -- name of the splash file which has to be placed inside the meta directory
    splash = "splash.png",
    superuser = false,
    -- needs to be true if an uninstall-option should be provided
    -- NOTE: atm installing serveral thousands files will slow down the installation process
    write_manifest = true,
    support_uninstall = true,

    recommended_destinations =
    {
        "/usr/local/games",
        "/opt/",
        MojoSetup.info.homedir,
    },

    Setup.Readme
    {
        description = "README",
        source = "README.liflg"
    },

    Setup.Media
    {
        -- unique identifier for the cd/dvd-rom SAMPLE: "fakk2-cd"
        id = "",
        -- this string will be shown to the end-user SAMPLE: "FAKK2-Loki CDROM"
        description = "",
        -- unique file to decide if a disc is the right one SAMPLE: "fakk/pak0.pk3"
        uniquefile = ""
    },

    Setup.DesktopMenuItem
    {
        disabled = false,
        -- name of the menu-entry. SAMPLE: "Heavy Metal: FAKK2"
        name = "",
        -- generic name. SAMPLE: "Ego-Shooter"
        genericname = "",
        -- tooltip SAMPLE "play Heavy Metal: FAKK2"
        tooltip = "",
        builtin_icon = false,
        -- path to icon file, realtive to the base-dir of the installation
        icon = "icon.xpm",
        -- gamebinary or startscript, "%0/" stands for the base directory of the installation SAMPLE: "%0/fakk2.sh"
        commandline = "",
        category = "Game",
    },

    -- contains one or more Setup.Option children (only one of them can be selected at the same time)
    Setup.OptionGroup
    {
        description = "Take one of two",

        Setup.Option
        {
            -- selected by default
            value = true,
            bytes = 0,
            description = "TAKE ME!",
        },

        Setup.Option
        {
            bytes = 0,
            description = "NO, TAKE ME!",
        },
    },

   Setup.Option
    {
        value = true,
        -- user will not be asked about this option, will be installed always
        required = true,
        disabled = false,
        -- size of the files, used only(?) for progressbar, Mojosetup does not check available space
        bytes = 390000000,
        description = "Required game data",
        tooltip = "Needs the LOKI-CDROM",

        -- no source = "xy" means installing from the "data"-dir of the installer
        Setup.File
        {
            -- installs file1 and the complete dir1 from the "data"-dir of the installer
            wildcards = { "file1", "dir1/*" },

            filter = function(dest)
                -- sets permission "0755" for every file that has "game-binary" in its name
                if ( string.match(dest, "game-binary") ) then
                    return dest, "0755"
                end

                -- do not install files named "TRANS.TBL"
                if dest == "TRANS.TBL" then
                    return nil
                end

                return dest
            end
        },

        Setup.File
        {
            -- sets the source to another value SAMPLE: "media://cd-id/", "base:///patch-1.1.tar"
            source = "",
            -- copies every *.pk3 and *.cfg file from the "fakk"-directory
            wildcards = { "fakk/*.pk3", "fakk/*.cfg" }
        },
    },
}

