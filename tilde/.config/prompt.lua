#!/usr/bin/env lua
-- generates a reasonably nice prompt
--
-- NOTE: returning "" instead of nil in block functions
--       is delibete, penlight lists use nil as a marker
require 'pl'
require 'lfs'
stringx.import()

local PATH_COLOR = "white"
local PATH_SIGIL = ""

local GIT_COLOR = "blue"
local GIT_SIGIL = ""

local PROMPT_COLOR = "white"
local PROMPT_WARN_SIGIL = "✗"
local PROMPT_SIGIL = "»"

local COLORS = {
    ["black"] = "\27[90m",
    ["red"] = "\27[91m",
    ["green"] = "\27[92m",
    ["yellow"] = "\27[93m",
    ["blue"] = "\27[94m",
    ["magenta"] = "\27[95m",
    ["cyan"] = "\27[96m",
    ["white"] = "\27[97m",

    ["bold"] = "\27[1m",
    ["reset"] = "\27[0m",
}

--
-- prompt blocks
--
function path()
    local home = os.getenv("HOME")
    local cwd = lfs.currentdir()
    if home ~= nil and cwd:startswith(home) then
        cwd = cwd:replace(home, "~", 1)
    end
    return color(PATH_COLOR, PATH_SIGIL .. cwd)
end

function git_branch()
    local git_ps = io.popen("git branch --show-current 2>/dev/null")
    local git_branch = git_ps:read("a"):strip()
    local ps_status = git_ps:close()
    if ps_status then 
        return color(GIT_COLOR, GIT_SIGIL .. git_branch)
    else
        return ""
    end
end

function prompt()
    local last_ret = os.getenv("LAST_RET") or ""
    if last_ret == "0" then
        return color("white", PROMPT_SIGIL .. " ")
    else
        local warning = PROMPT_WARN_SIGIL
        return color("red", warning .. " " .. PROMPT_SIGIL .. " ")
    end
end

--
-- utilities
--
function color(col, str)
    -- %{ ... %} is used to inform zsh that the inner text
    -- takes no space on the prompt line; if it doesn't know
    -- that it'll draw the cursor in wonky places
    if str ~= "" then
        return "%{"
            .. COLORS["bold"]
            .. COLORS[col]
            .. "%}"
            .. str
            .. "%{"
            .. COLORS["reset"]
            .. "%}"
    else
        return ""
    end
end

--
-- draw prompt blocks
--
function not_empty(str) return str ~= "" end
io.write(List{
    path(),
    git_branch(),
    prompt(),
}:filter(not_empty):join(" "))
