function data()
return {
	info = {
		minorVersion = 1,
		severityAdd = "NONE",
		severityRemove = "WARNING",
		name = _("mod_name"),
		description = _("mod_desc"),
		authors = {
		    {
		        name = "ModWerkstatt",
		        role = "CREATOR",
		    },
		},
		tags = { "europe", "waggon", "schuettgut", "deutschland", "germany", "UIC", "gueterwagen", "db" },
		tfnetId = { },
		minGameVersion = 0,
		dependencies = { },
		url = { "" },
	  
		params = {
			{
				key = "fcs090fake",
				name = _("Fake_fcs090_wagen"),
				values = { "No", "Yes", },
				tooltip = _("option_fake_fcs090_wagen_desc"),
				defaultIndex = 0,
			},			
			{
				key = "soundCheck",
				name = _("sound_check"),
				uiType = "CHECKBOX",
				values = { "No", "Yes", },	
				tooltip = _("option_sound_check"),			
				defaultIndex = 1,	
			},
        },
	},
	options = {
	},
	
	runFn = function (settings, modParams)
	local params = modParams[getCurrentModId()]

        local hidden = {
			["090_basf_fake.mdl"] = true,
			["090_db_fake.mdl"] = true,
			["090_quarzwerke_fake.mdl"] = true,
			["090_rag_fake.mdl"] = true,
			["090_basf_fake.mdl"] = true,
			["090_db_fake.mdl"] = true,
			["090_dbag_fake.mdl"] = true,
			["090_quarzwerke_fake.mdl"] = true,
			["090_rag_fake.mdl"] = true,
			["092_db_fake.mdl"] = true,
			["092_dbag_fake.mdl"] = true,
			["092_dbcargo_fake.mdl"] = true,
			["70_db_fake.mdl"] = true,
        }

		local modelFilter = function(fileName, data)
			local modelName = fileName:match('/Eds([^/]*.mdl)')
							or fileName:match('/Fcs([^/]*.mdl)')
							or fileName:match('/Otmm([^/]*.mdl)')
			return (modelName==nil or hidden[modelName]~=true)
		end

        if modParams[getCurrentModId()] ~= nil then
			local params = modParams[getCurrentModId()]
			if params["fcs090fake"] == 0 then
				addFileFilter("model/vehicle", modelFilter)
			end
		else
			addFileFilter("model/vehicle", modelFilter)
		end
		
		local function metadataHandler(fileName, data)
			if params.soundCheck == 0 then
				if fileName:match('/vehicle/waggon/Fcs090/Eds([^/]*.mdl)') 
				or fileName:match('/vehicle/waggon/Fcs090/Fcs([^/]*.mdl)')  
				or fileName:match('/vehicle/waggon/Fcs090/Otmm([^/]*.mdl)')    
				or fileName:match('/vehicle/waggon/Fcs090/Fake/Eds([^/]*.mdl)') 
				or fileName:match('/vehicle/waggon/Fcs090/Fake/Fcs([^/]*.mdl)')  
				or fileName:match('/vehicle/waggon/Fcs090/Fake/Otmm([^/]*.mdl)') 
				then
					data.metadata.railVehicle.soundSet.name = "waggon_freight_old"
				end
			end
			return data
		end

		addModifier( "loadModel", metadataHandler )
	end
	}
end
