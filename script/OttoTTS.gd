extends AudioStreamPlayer2D


func loadJSON(json_file_path:String) -> Dictionary:
	var file = FileAccess.open(json_file_path, FileAccess.READ)
	var content = file.get_as_text()
	var finish = JSON.parse_string(content)
	return finish
	
func find_sub_array(main_array: Array, sub_array: Array) -> int:
	var sub_array_length = sub_array.size()
	for i in range(main_array.size() - sub_array_length + 1):
		if main_array.slice(i, i + sub_array_length) == sub_array:
			return i
	return -1


func ottoTTS(phrase:String, parent = null, createNewNode = true) -> void:
	var audio_stream_player: Node
	audio_stream_player = self if !createNewNode else AudioStreamPlayer2D.new()
	if createNewNode:
		parent.add_child(audio_stream_player)
		
	var play_stream_file = func(path:String):
		var streamFile = load(path)
		audio_stream_player.stream = streamFile
		audio_stream_player.play()

	
	var fallBackTone = "_"
	var longTokenRule = loadJSON("res://assets/tts/longTokenRule.json")
	var pinyinRule = loadJSON("res://assets/tts/hanzi-no-tone-pinyin-table.json")
	var pinyinResult = []
	var toneList = ["_","a","ai","an","ao","ba","bai","ban","bang","bao","bei","ben","beng","bi","bian","biao","bie","bin","bing","bo","bu","cai","can","cang","cao","ceng","cha","chai","chan","chang","chao","che","chen","cheng","chi","chong","chou","chu","chuan","chuang","chui","chun","ci","cong","cou","cu","cui","cun","cuo","da","dai","dan","dang","dao","de","deng","di","dian","diao","die","ding","dong","dou","du","duan","dui","dun","duo","e","ei","en","eng","er","fa","fan","fang","fei","fen","feng","fou","fu","ga","gai","gan","gang","gao","ge","gei","gen","geng","gong","gou","gu","gua","guai","guan","guang","gui","gun","guo","ha","hai","han","hao","he","hei","hen","heng","hong","hou","hu","hua","huai","huan","huang","hui","hun","huo","ji","jia","jian","jiang","jiao","jie","jin","jing","jiong","jiu","ju","juan","jue","jun","ka","kai","kan","kang","kao","ke","kiu","kong","kou","ku","kua","kuai","kuan","kuang","kui","kun","la","lai","lan","lang","lao","le","lei","li","lia","lian","liang","liao","lie","lin","ling","liu","long","lu","luan","lun","luo","lv","ma","mai","man","mang","mao","me","mei","men","meng","mi","mian","miao","min","ming","miu","mo","mu","na","nai","nan","nao","ne","nei","neng","ni","nian","niao","ning","niu","nong","nu","nuo","nv","nve","o","ou","pa","pai","pan","pao","pei","pen","peng","pi","pian","piao","pin","ping","po","pu","qi","qian","qiang","qiao","qie","qin","qing","qiong","qiu","qu","quan","que","qun","ran","rang","rao","re","ren","reng","ri","rong","rou","ru","rui","ruo","sa","sai","san","sang","sao","se","sha","shan","shang","shao","she","shen","sheng","shi","shou","shu","shua","shuai","shuang","shui","shun","shuo","si","song","su","suan","sui","sun","suo","ta","tai","tan","tang","tao","teng","ti","tian","tiao","tie","ting","tong","tou","tu","tuan","tui","tun","tuo","wa","wai","wan","wang","wei","wen","wo","wu","xi","xia","xian","xiang","xiao","xie","xin","xing","xiong","xiu","xu","xuan","xue","xun","ya","yan","yang","yao","ye","yi","yin","ying","yong","you","yu","yuan","yue","yun","za","zai","zan","zao","ze","zei","zen","zeng","zha","zhan","zhang","zhao","zhe","zhei","zhen","zheng","zhi","zhong","zhou","zhu","zhua","zhuan","zhuang","zhui","zhun","zhuo","zi","zong","zou","zu","zuan","zui","zun","zuo"]

	# 将文字转为拼音
	var pinyinAtempt = phrase.split(" ")
	for attempt in pinyinAtempt:
		if toneList.has(attempt):
			pinyinResult.append(attempt)
		else:
			for token in attempt:
				if pinyinRule.has(token):
					pinyinResult.append(pinyinRule[token][0])
				else:
					pinyinResult.append(fallBackTone)
	# 原声大碟放送
	for rule in longTokenRule:
		var ruleArray = Array(rule.split(" "))
		var index = find_sub_array(pinyinResult, ruleArray)
		if index != -1:
			pinyinResult[index] = "-"+longTokenRule[rule][0]
			for i in range(len(ruleArray) -1):
				pinyinResult.remove_at(index+1)
	print(pinyinResult)
			
	for tone in pinyinResult:
		if tone[0] == "-":
			tone = tone.erase(0, 1)
			play_stream_file.call("res://audio/longToken/"+ tone +".mp3")
		else:
			play_stream_file.call("res://audio/simpleToken/"+ tone +".wav")
		await audio_stream_player.finished

func _ready() -> void:
	ottoTTS("在这里输入要寄的单词", null, false)
