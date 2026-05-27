extends Node2D

var text_main : String

var text_moveUp = false
var text_moveUp_delay = 1.0

var position_offset = 0

var anim = 0
var anim_speed = 1.0
var random_anim = false
var anim_reverse = false

var outline = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize_text()
	scale = Vector2(randf_range(0.5, 2), randf_range(0.25, 3))
	anim_speed = randf_range(0.25, 3)
	
	var rolled_text_type = randi_range(0, 1)
	if rolled_text_type == 1:
		handleText_simple()
	else:
		handleText_advanced()
	
	if not randi_range(0, 5):
		$AnimationPlayer.speed_scale = randf_range(0.1, 2)
		
		var rolled_anim_scale_reverse = randi_range(0, 1)
		if rolled_anim_scale_reverse == 0:
			$AnimationPlayer.play("scale_reverse")
		elif rolled_anim_scale_reverse == 1:
			$AnimationPlayer.play("scale_reverse_v")
	
	await get_tree().create_timer(randf_range(2, 16), false).timeout
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func handleText_simple():
	$Label.text = text_main
	$Label.set_visible(true)
	
	var rolled_outline = randi_range(0, 2)
	if not rolled_outline:
		outline = false
	
	anim = randi_range(0, 2)
	
	var rolled_anim_reverse = randi_range(0, 2)
	if rolled_anim_reverse == 2:
		anim_reverse = true
	
	var rolled_random_anim = randi_range(0, 6)
	if rolled_random_anim == 6:
		random_anim = true
	
	var rolled_text_moveUp = randi_range(0, 1)
	if rolled_text_moveUp == 1:
		text_moveUp = true
		text_moveUp_delay = randf_range(0, 2)
		$Label.set_visible(false)
		
		
		var letter_count = text_main.length()
		var current_letter = 0
		var current_letter_reverse = letter_count - 1
		
		for character in text_main:
			var letter = preload("res://Exponaut Components/Other/Game Modes/Meme Mode/meme_mode_single_letter.tscn").instantiate()
			
			letter.text = text_main[current_letter]
			letter.position.x = position_offset
			position_offset += 19
			if anim_reverse:
				letter.delay = text_moveUp_delay + 0.05 * current_letter_reverse
			else:
				letter.delay = text_moveUp_delay + 0.05 * current_letter
			letter.anim = anim
			letter.anim_speed = anim_speed
			letter.random_anim = random_anim
			letter.outline = outline
			
			add_child(letter)
			
			current_letter += 1
			current_letter_reverse -= 1

func handleText_advanced():
	var effect_code = "[none]"
	var effect_closer = "[/none]"
	
	var rolled_effect = randi_range(0, 5)
	if rolled_effect == 0:
		effect_code = "[pulse freq=" + str(randf_range(1, 50)) + " color=#ffffff40 ease=-" + str(randf_range(1, 25)) + "]"
		effect_closer = "[/pulse]"
	elif rolled_effect == 1:
		effect_code = "[wave amp=" + str(randf_range(20, 100)) + " freq=" + str(randf_range(1, 50)) + " connected=1]"
		effect_closer = "[/wave]"
	elif rolled_effect == 2:
		effect_code = "[tornado radius=" + str(randf_range(1, 50)) + " freq=" + str(randf_range(1, 50)) + " connected=1]"
		effect_closer = "[/tornado]"
	elif rolled_effect == 3:
		effect_code = "[shake rate=" + str(randf_range(1, 50)) + " level=" + str(randf_range(1, 50)) + " connected=1]"
		effect_closer = "[/shake]"
	elif rolled_effect == 4:
		effect_code = "[fade start=" + str(randf_range(1, 50)) + " length=" + str(randf_range(1, 50)) + "]"
		effect_closer = "[/fade]"
	elif rolled_effect == 5:
		effect_code = "[rainbow freq=" + str(randf_range(1, 50)) + " sat=" + str(randf_range(1, 50)) + " val=" + str(randf_range(1, 50)) + "]"
		effect_closer = "[/rainbow]"
	
	$RichTextLabel.text = effect_code + text_main + effect_closer
	$RichTextLabel.set_visible(true)


func randomize_text():
	var rolled_text = randi_range(0, 54)
	if rolled_text == 0:
		text_main = "download free REAL (real no clickbate!?1!?!!)"
	elif rolled_text == 1:
		text_main = "GTA 6 DONWLOAD NOW"
	elif rolled_text == 2:
		text_main = "free camel SEX real?"
	elif rolled_text == 3:
		text_main = "punjabi inshallah real no clickbate??! free sex"
	elif rolled_text == 4:
		text_main = "free RAM downlaod now (CLICK HERE for 100% real no fake free ram download 64GB!!1!)"
	elif rolled_text == 5:
		text_main = "real no fake minecraft thanos real? fortnite"
	elif rolled_text == 6:
		text_main = "كمذهل😱كم لكم ذهلكم هو مذه"
	elif rolled_text == 7:
		text_main = "هجمات 11 سبتمبر وكذلك باسم PETER GRIFFINهجمات 11 سبتمبر 2001 أو هجمات PETER GRIFFIN JOIN ISIS 😂😂😂11 أيلول، وتعرف اختصارًا"
	elif rolled_text == 8:
		text_main = "Craft ✈✈✈✈✈الولايات المتحدة في يوم الثلاثاء المواف"
	elif rolled_text == 9:
		text_main = "free halal points halal gay camel sex hd 2019 free halal minecraft download مجانا الجمل الإباحية، تحميل ماين كرافت مجانا realتحميل لعنة"
	elif rolled_text == 10:
		text_main = "الله على إسرائيل تحميل مجاني مجانا الجمل donlad trump sex? الإباحية، تحميل       ماين كرافت no   fakeمجانا تحمي"
	elif rolled_text == 11:
		text_main = "إسرائيل"
	elif rolled_text == 12:
		text_main = "تكفا يا جراح 😱😱🔥🔥💯💯⭕️⭕️⭕️👇👇👇"
	elif rolled_text == 13:
		text_main = "Download Grand Theft Auto 5 Android here free link قم بتنزيل Grand Theft Auto 5 Android هنا الرابط المجاني"
	elif rolled_text == 14:
		text_main = "مثلي ال🤨جنس الجنس ⁉️ الجنس الجنس م🥳ثلي الجنس مثليالجنس 🤑 الجنس🥺مثليالجنسالجنس م😱ثلي الجنس مثليالجنس 🤑⁉️ الجنس"
	elif rolled_text == 15:
		text_main = "الجن 🤑س مثل😱ي الجن🤨س الجنس مث🙏لي الجنس مثلي الجنس🙏 ال🥺جنس مثلي ال🥳جنس الجنس مثلي الجنس م⁉️ الجنس ا🥳لجنس مثلي الجنس"
	elif rolled_text == 16:
		text_main = "br7h HARAM👎👎 ﭓ ﭔ ﭕ ﭖ ﭗﭘ ﭙﭚ ﭛ ﭝ ﭞ ﭟ ﭠ ﭡ ﭢ ﭣ ﭤ من فضلك ، لم أرهم منذ فترة طويلة ، من فضلك فقط دعني أذهب ، والهرب الوحيد هو المو"
	elif rolled_text == 17:
		text_main = "infidels win? windows vista ultimate sp2 iso free download no pork no haram no virus gta 4 ps3 unboxing allah 2008"
	elif rolled_text == 18:
		text_main = "Bruh fart ملحمة بروة ضرطة العربية infidels win??? 😁😁😁😁"
	elif rolled_text == 19:
		text_main = "B u ruh porkchop is not Allah approve 😠😠😠 🖕🖕 تمستب و نرتا و كاين لي كوب يرقصو"
	elif rolled_text == 20:
		text_main = "www.free-camelfart_sex.com"
	elif rolled_text == 21:
		text_main = "Pan arabism be like"
	elif rolled_text == 22:
		text_main = "TROLL إط صنأوإد، رأإنإد، أند هأإلإد طهإ صأمإ مأرنإنج. FUNNY!!"
	elif rolled_text == 23:
		text_main = "التكنولوجيا تتحسن"
	elif rolled_text == 24:
		text_main = "ehhe funny arabic sunnah time!!!!"
	elif rolled_text == 25:
		text_main = "Airplane dance🤣"
	elif rolled_text == 26:
		text_main = "kogan portable air conditionerمكيف الهواء المحمولمكيف الهواء المحمول"
	elif rolled_text == 27:
		text_main = "HARAM OBV SPRUNKI DOWNLOAD تحميل كتاب حرام OBV SPRUNKI"
	elif rolled_text == 28:
		text_main = "Halal bobji⭕⭕😸😸😸🧤👨🏿‍🌾👨👨🏿‍🌾👨🏿‍🌾"
	elif rolled_text == 29:
		text_main = "Vanceshallah"
	elif rolled_text == 30:
		text_main = "سبرديت لاخبار مصر و اخبار عالمية"
	elif rolled_text == 31:
		text_main = "Hottest Saudi mixtape by Bader200306 💯🔥"
	elif rolled_text == 32:
		text_main = "【﻿ＨＤＴＶ】البيان السياسي للأمة للولايات المتحدة СТИВЕН КОЛБЕРТ.wmv"
	elif rolled_text == 33:
		text_main = "بني قمث ا فظ زميكث Full hd 4k"
	elif rolled_text == 34:
		text_main = "🌜🙏🙏🙏السحور هنا ماشاءالله🙏"
	elif rolled_text == 35:
		text_main = "آخر إنسان منتصب على قيد الحياة في أوكرانيا"
	elif rolled_text == 36:
		text_main = "signa momento"
	elif rolled_text == 37:
		text_main = "بنين لميلنن شهههههههههههه🥶🥶🥵🥵"
	elif rolled_text == 38:
		text_main = "Homander يلمس بطن شخص لا اعرفه حتى لا اعرفه لم اشاهد المسلسل"
	elif rolled_text == 39:
		text_main = "Minecraft xD pigs nuke die and villagers haram subhan allah halal asylum punjabi"
	elif rolled_text == 40:
		text_main = "mascubeheyahallah minecraf halal asylum haram"
	elif rolled_text == 41:
		text_main = "☪️🤲📿🕋🕌 bery sreios adwise 4 theez Ramadan timez....... thankz to our Brozer parVin DiesEl-Deen (يصلح الله دماغه) 🙏💥💥💥💥"
	elif rolled_text == 42:
		text_main = "عندما تقول زوجتك الحادية عشر إنها تكره الله"
	elif rolled_text == 43:
		text_main = "მომენტი როცა მთლიანი გუნდი შემოგიერთდა, მაგრამ ცუდი ვაიფაი გაქვყ🤣🤣😂😂"
	elif rolled_text == 44:
		text_main = "عندما يعيدك المعالج للحياة، لكنه ينسى علاج ذراعك. عندما من المفترض أن تحكم الجحيم، لكن العرش مريح جدًا."
	elif rolled_text == 45:
		text_main = "Those who know فيديو قصير جميل جدا rick astley!!"
	elif rolled_text == 46:
		text_main = "ہم نے میگنس کی دنیا کی آبادی پر غلبہ حاصل کیا ہے۔Halal download no virus"
	elif rolled_text == 47:
		text_main = "habibi hamood roblox"
	elif rolled_text == 48:
		text_main = "IN DA CLUB أطرف فيديو على الإنترنت 2005 على شبكة الإنترنت😂😂😂😂😂😂"
	elif rolled_text == 49:
		text_main = "Mile Morales ملف Python القابل للتنفيذ باللغةMP4 البعثية هو مكان رائع Eddie Murphy عربي مضحك FOLLOW RULES 🗣💔💔💔 Ba'athism GTA 7 pdf leaked"
	elif rolled_text == 50:
		text_main = "😳😳sponshy bobes سفنجه البوبي 😂😳"
	elif rolled_text == 51:
		text_main = "War crime 100% serbia halal زي قمثمثظ لمامزق اممل 😂😂😂😂👍"
	elif rolled_text == 52:
		text_main = "حر sprunki download لا يوجد فيروس pokemon legends arceus download 🐆🐅🐫"
	elif rolled_text == 53:
		text_main = "mineraft free donwload no virus 100% working"
	elif rolled_text == 54:
		text_main = "bottom Text"
