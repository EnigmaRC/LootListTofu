local _, addon = ...

groupMemberNames = {};
addon.test = "Hello";

function addon:determineGroupMemberNames()
    for raidIndex = 1, GetNumGroupMembers(), 1 do
        name = GetRaidRosterInfo(raidIndex);
        table.insert(groupMemberNames, name);
    end
end

function addon:iterateOverGroupMemberNames()
    determineGroupMemberNames(groupMemberNames);
    for _, memberName in ipairs(groupMemberNames) do
        print(memberName);
    end
end

function GroupMembers:sayHello()
    print('Called from function');
end

iterateOverGroupMemberNames();