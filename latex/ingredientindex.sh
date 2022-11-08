#!/bin/bash
#
# BSD 3-Clause License
#
# Copyright (c) 2023 Quux System and Technology. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
##############################################################################
#
# Process the ingredient index file externally.

export LC_ALL="en_US.UTF-8"

INDEX_FILE="$1"

KEYWORD=""
PAGE=""

function indexentry()
{
	local keyword="$1"
	local page="$2"

	case "${keyword}" in
	"葱姜末")
		indexentry "葱末" "${page}"
		indexentry "姜末" "${page}"
		return
		;;
	"鸡足鸭掌")
		indexentry "鸡足" "${page}"
		indexentry "鸭掌" "${page}"
		return
		;;
	"净鸡腿脯肉")
		indexentry "鸡腿肉" "${page}"
		indexentry "鸡脯肉" "${page}"
		return
		;;
	esac

	case "${keyword}" in
	"净"*)			keyword="${keyword#净}"				;;
	esac

	case "${keyword}" in
	"生菜")			;;
	"生细"*)		keyword="${keyword#生细}"			;;
	"生鲜"*)		keyword="${keyword#生鲜}"			;;
	"生"*)			keyword="${keyword#生}"				;;
	"细"*)			keyword="${keyword#细}"				;;
	"活"*)			keyword="${keyword#活}"				;;
	"鲜活"*)		keyword="${keyword#鲜活}"			;;
	"鲜"*)			keyword="${keyword#鲜}"				;;
	"好"*)			keyword="${keyword#好}"				;;
	"熟"*)			keyword="${keyword#熟}"				;;
	"嫩豆腐")		;;
	"嫩"*)			keyword="${keyword#嫩}"				;;
	"老"*)			keyword="${keyword#老}"				;;
	"大米"*)		;;
	"大葱"*)		;;
	"大蒜"*)		;;
	"大料"*)		;;
	"大头菜"*)		;;
	"大金钩"*)		;;
	"大红"*)		keyword="${keyword#大红}"			;;
	"大"*)			keyword="${keyword#大}"				;;
	"剥净鲜"*)		keyword="${keyword#剥净鲜}"			;;
	"剥净"*)		keyword="${keyword#剥净}"			;;
	"剔刺"*)		keyword="${keyword#剔刺}"			;;
	"去壳"*)		keyword="${keyword#去壳}"			;;
	"去骨净嫩"*)	keyword="${keyword#去骨净嫩}"		;;
	"去骨熟"*)		keyword="${keyword#去骨熟}"			;;
	esac

	case "${keyword}" in
	*"一副")		keyword="${keyword%一副}"			;;
	*"一条")		keyword="${keyword%一条}"			;;
	*"一个")		keyword="${keyword%一个}"			;;
	*"一只")		keyword="${keyword%一只}"			;;
	*"一尾")		keyword="${keyword%一尾}"			;;
	*"一方")		keyword="${keyword%一方}"			;;
	*"二个")		keyword="${keyword%二个}"			;;
	*"三只")		keyword="${keyword%三只}"			;;
	*"三尾")		keyword="${keyword%三尾}"			;;
	*"三个")		keyword="${keyword%三个}"			;;
	*"四个")		keyword="${keyword%四个}"			;;
	*"四段")		keyword="${keyword%四段}"			;;
	*"八个")		keyword="${keyword%八个}"			;;
	*"八对")		keyword="${keyword%八对}"			;;
	*"九条")		keyword="${keyword%九条}"			;;
	esac

	case "${keyword}" in
	*"银耳")		keyword="银耳"						;;
	"五香面")		keyword="五香粉!${keyword}"			;;
	"食盐")			keyword="盐!${keyword}"				;;
	"香料面")		keyword="香料!${keyword}"			;;
	"整香料")		keyword="香料!${keyword}"			;;
	"大料面")		keyword="八角!${keyword}"			;;
	"干辣椒")		keyword="辣椒!${keyword}"			;;
	"干海椒")		keyword="辣椒!${keyword}"			;;
	"干口蘑")		keyword="口蘑!${keyword}"			;;
	"口蘑豆豉")		keyword="豆豉!${keyword}"			;;
	"酱油")			;;
	*"酱油"*)		keyword="酱油!${keyword}"			;;
	"窝油") 		keyword="酱油!${keyword}"			;;
	"红食色") 		keyword="红色素!${keyword}"			;;
	"萝卜") 		;;
	*"萝卜"*) 		keyword="萝卜!${keyword}"			;;
	"姜")			;;
	"姜"*)			keyword="姜!${keyword}"				;;
	"子姜")			keyword="姜!${keyword}"				;;
	"嫩姜片")		keyword="姜!${keyword}"				;;
	"冰糖")			;;
	"冰糖"*)		keyword="冰糖!${keyword}"			;;
	"鸡蛋")			;;
	"鸡蛋"*)		keyword="鸡蛋!${keyword}"			;;
	"蛋皮")			keyword="鸡蛋!${keyword}"			;;
	"蛋黄粉")		keyword="鸡蛋!${keyword}"			;;
	"花椒")			;;
	"花椒"*)		keyword="花椒!${keyword}"			;;
	*"花椒")		keyword="花椒!${keyword}"			;;
	"胡椒")			;;
	"胡椒"*)		keyword="胡椒!${keyword}"			;;
	"草碱")			;;
	"草碱"*)		keyword="草碱!${keyword}"			;;
	"油炸花生米")	keyword="花生米!${keyword}"			;;
	"小白菜")		;;
	"小白菜"*)		keyword="小白菜!${keyword}"			;;
	"干冬菇")		keyword="冬菇!${keyword}"			;;
	"豌豆")			;;
	"豌豆"*)		keyword="豌豆!${keyword}"			;;
	"豆尖")			keyword="豌豆!豌豆尖!${keyword}"	;;
	"嫩豌豆")		keyword="豌豆!${keyword}"			;;
	"干豌豆")		keyword="豌豆!${keyword}"			;;
	"青黄豆")		keyword="黄豆!${keyword}"			;;
	"新鲜蚕豆")		keyword="蚕豆"						;;
	"青嫩鲜蚕豆仁")	keyword="蚕豆!蚕豆仁"				;;
	"扁豆仁")		keyword="扁豆!${keyword}"			;;
	"醪糟")			;;
	"醪糟"*)		keyword="醪糟!${keyword}"			;;
	"酒米粉")		keyword="酒米!${keyword}"			;;
	"韭菜")			;;
	"韭菜"*)		keyword="韭菜!${keyword}"			;;
	"菠菜")			;;
	"菠菜"*)		keyword="菠菜!${keyword}"			;;
	"莴笋")			;;
	"莴笋"*)		keyword="莴笋!${keyword}"			;;
	"丝瓜皮")		keyword="丝瓜!${keyword}"			;;
	"豆腐乳水")		;;
	*"豆腐乳水"*)	keyword="豆腐乳水"					;;
	"豆腐")			;;
	"豆腐皮")		;;
	*"豆腐"*)		keyword="豆腐!${keyword}"			;;
	"鸡脯肉")		keyword="鸡脯!${keyword}"			;;
	"鸡脯茸子")		keyword="鸡脯!${keyword}"			;;
	"鸡腿肉")		keyword="鸡腿!${keyword}"			;;
	"面包粉")		keyword="面包!${keyword}"			;;
	"干面粉")		keyword="面粉!${keyword}"			;;
	"大米粉")		keyword="大米!${keyword}"			;;
	"干豆粉")		keyword="豆粉!${keyword}"			;;
	"水豆粉")		keyword="豆粉!${keyword}"			;;
	"芝麻酱")		keyword="芝麻!${keyword}"			;;
	"麻油")			keyword="香油!${keyword}"			;;
	"小磨麻油")		keyword="香油!${keyword}"			;;
	"酥肉")			;;
	"酥肉"*)		keyword="酥肉!${keyword}"			;;
	"葱白")			keyword="葱!${keyword}"				;;
	"葱白"*)		keyword="葱!葱白!${keyword}"		;;
	"葱")			;;
	"葱"*)			keyword="葱!${keyword}"				;;
	"大葱")			keyword="葱!${keyword}"				;;
	"蒜")			;;
	"蒜苗")			;;
	"蒜苗段")		keyword="蒜苗!${keyword}"			;;
	"蒜"*)			keyword="蒜!${keyword}"				;;
	"大蒜")			keyword="蒜!${keyword}"				;;
	"大蒜片")		keyword="蒜!蒜片!${keyword}"		;;
	"独蒜")			keyword="蒜!${keyword}"				;;
	"青菜心")		keyword="青菜!${keyword}"			;;
	"绿色小菜")		keyword="青菜!${keyword}"			;;
	"绿色菜叶")		keyword="青菜!${keyword}"			;;
	"青笋片")		keyword="青笋!${keyword}"			;;
	"田鸡腿")		keyword="田鸡!${keyword}"			;;
	"湘莲子")		keyword="湘莲!${keyword}"			;;
	"辣椒")			;;
	"辣椒"*)		keyword="辣椒!${keyword}"			;;
	"油辣椒")		keyword="辣椒!${keyword}"			;;
	"红辣椒油")		keyword="辣椒!辣椒油!${keyword}"	;;
	"泡辣椒")		keyword="辣椒!${keyword}"			;;
	"红泡辣椒")		keyword="辣椒!${keyword}"			;;
	"泡红辣椒")		keyword="辣椒!${keyword}"			;;
	"泡海椒")		keyword="辣椒!${keyword}"			;;
	"泡红海椒")		keyword="辣椒!${keyword}"			;;
	"鱼辣椒")		keyword="辣椒!${keyword}"			;;
	"泡鱼辣椒")		keyword="辣椒!${keyword}"			;;
	"大金钩")		keyword="金钩!${keyword}"			;;
	"火腿")			;;
	"肥瘦熟火腿")	keyword="火腿!肥瘦火腿"				;;
	*"火腿汤")		keyword="汤!${keyword}"				;;
	*"火腿"*)		keyword="火腿!${keyword}"			;;
	*"宣腿"*)		keyword="火腿!${keyword}"			;;
	"小毛鱼翅")		keyword="鱼翅!${keyword}"			;;
	"莲米")			keyword="莲子!${keyword}"			;;
	"整猪头")		keyword="猪头"						;;
	"猪头肉")		keyword="猪头!${keyword}"			;;
	"猪心子")		keyword="猪心"						;;
	"猪板油")		keyword="猪油!${keyword}"			;;
	"板油")			keyword="猪油!${keyword}"			;;
	"猪网油")		keyword="猪油!${keyword}"			;;
	"网油")			keyword="猪油!${keyword}"			;;
	"化猪油")		keyword="猪油!${keyword}"			;;
	"猪肚头")		keyword="猪肚!${keyword}"			;;
	"肚头")			keyword="猪肚!${keyword}"			;;
	"肚子")			keyword="猪肚!${keyword}"			;;
	"肚片")			keyword="猪肚!${keyword}"			;;
	"肉片")			keyword="猪肉!${keyword}"			;;
	"腰花")			keyword="猪腰!${keyword}"			;;
	"猪肥肠头")		keyword="猪肥肠!${keyword}"			;;
	"猪肥膘")		keyword="猪肥肉!${keyword}"			;;
	"猪肥膘肉")		keyword="猪肥肉!${keyword}"			;;
	"肥猪肉")		keyword="猪肥肉!${keyword}"			;;
	"肥膘")			keyword="猪肥肉!${keyword}"			;;
	"肥肉")			keyword="猪肥肉!${keyword}"			;;
	"肥膘肉")		keyword="猪肥肉!${keyword}"			;;
	"肥膘猪肉")		keyword="猪肥肉!${keyword}"			;;
	"猪生瘦肉")		keyword="猪瘦肉!${keyword}"			;;
	"猪后腿瘦肉")	keyword="猪瘦肉!${keyword}"			;;
	"五花肉")		keyword="猪肥瘦肉!${keyword}"		;;
	"五花猪肉")		keyword="猪肥瘦肉!${keyword}"		;;
	"肥五花猪肉")	keyword="猪肥瘦肉!${keyword}"		;;
	"肥瘦肉")		keyword="猪肥瘦肉!${keyword}"		;;
	"肥瘦猪肉")		keyword="猪肥瘦肉!${keyword}"		;;
	"肥瘦猪肉丝")	keyword="猪肥瘦肉!${keyword}"		;;
	"瘦猪肉")		keyword="猪瘦肉!${keyword}"			;;
	"瘦肉")			keyword="猪瘦肉!${keyword}"			;;
	"猪排骨")		;;
	"排骨")			keyword="猪排骨!${keyword}"			;;
	"猪"*"排骨")	keyword="猪排骨!${keyword}"			;;
	"猪肘")			;;
	"猪肘"*)		keyword="猪肘!${keyword}"			;;
	"肘子排骨汤")	keyword="汤!${keyword}"				;;
	"肘子"*)		keyword="猪肘!${keyword}"			;;
	"干猪肉皮")		keyword="猪肉皮!${keyword}"			;;
	"鲤鱼肉")		keyword="鲤鱼!${keyword}"			;;
	"岩鲤")			keyword="鲤鱼!${keyword}"			;;
	"岩鲤鱼")		keyword="鲤鱼!${keyword}"			;;
	"鲢鱼肉")		keyword="鲢鱼!${keyword}"			;;
	"鲢鱼头")		keyword="鲢鱼!${keyword}"			;;
	"罐头蟹黄")		keyword="蟹黄!${keyword}"			;;
	"刺参")			keyword="海参!${keyword}"			;;
	"开乌参")		keyword="海参!乌参"					;;
	*"清汤")		keyword="汤!${keyword}"				;;
	*"奶汤")		keyword="汤!${keyword}"				;;
	*"鸡汤")		keyword="汤!${keyword}"				;;
	*"虾汤")		keyword="汤!${keyword}"				;;
	*"肉汤")		keyword="汤!${keyword}"				;;
	*"骨汤")		keyword="汤!${keyword}"				;;
	"二汤")			keyword="汤!${keyword}"				;;
	"白菜心")		keyword="白菜!${keyword}"			;;
	"白菜秧心子")	keyword="白菜!${keyword}"			;;
	"黄秧白"*)		keyword="白菜!${keyword}"			;;
	"黄豆芽")		keyword="黄豆!${keyword}"			;;
	"黄豆芽瓣")		keyword="黄豆!黄豆芽!${keyword}"	;;
	"仔鸡翅膀")		keyword="鸡翅!${keyword}"			;;
	"仔鸡")			keyword="鸡!${keyword}"				;;
	"仔公鸡")		keyword="鸡!${keyword}"				;;
	"仔公鸡肉")		keyword="鸡肉!${keyword}"			;;
	"仔母鸡")		keyword="鸡!${keyword}"				;;
	"仔鸡肉")		keyword="鸡肉!${keyword}"			;;
	"嫩仔公鸡")		keyword="鸡!${keyword}"				;;
	"嫩仔鸡")		keyword="鸡!${keyword}"				;;
	"嫩公鸡")		keyword="鸡!${keyword}"				;;
	"公鸡")			keyword="鸡!${keyword}"				;;
	"嫩肥母鸡")		keyword="鸡!${keyword}"				;;
	"水盆仔鸡")		keyword="鸡!${keyword}"				;;
	"公鸡翅")		keyword="鸡翅!${keyword}"			;;
	"鸡化油")		keyword="鸡油!${keyword}"			;;
	"化鸡油")		keyword="鸡油!${keyword}"			;;
	"肉")			keyword="猪肉!${keyword}"			;;
	"腱子肉")		keyword="猪瘦肉!${keyword}"			;;
	"熟猪肥膘肉")	keyword="猪肥膘!猪肥膘肉!${keyword}";;
	"蹄筋")			keyword="猪蹄筋!${keyword}"			;;
	"仔蹄筋")		keyword="猪蹄筋!${keyword}"			;;
	"干大白蹄筋")	keyword="猪蹄筋"					;;
	"公鸡肉")		keyword="鸡肉!${keyword}"			;;
	*"仔鸭")		keyword="鸭!${keyword}"				;;
	*"鸭子")		keyword="鸭!${keyword}"				;;
	"肥"*"鸭")		keyword="鸭!${keyword}"				;;
	"水盆鸭")		keyword="鸭!${keyword}"				;;
	"鸭脚掌")		keyword="鸭掌!${keyword}"			;;
	"熟鸡蛋白")		keyword="鸡蛋!${keyword}"			;;
	"熟鸡脯肉")		keyword="鸡脯!${keyword}"			;;
	"熟鸡脯皮")		keyword="鸡脯!${keyword}"			;;
	"白鸡脯肉")		keyword="鸡脯!鸡脯肉"				;;
	"熟鸡皮")		keyword="鸡!${keyword}"				;;
	"熟阉鸡腿")		keyword="鸡腿!${keyword}"			;;
	"阉鸡腿")		keyword="鸡腿!${keyword}"			;;
	"嫩鸡腿肉")		keyword="鸡腿!${keyword}"			;;
	"熟母鸡肉")		keyword="鸡肉!${keyword}"			;;
	"肥母鸡")		keyword="鸡!${keyword}"				;;
	"白皮肥嫩母鸡")	keyword="鸡!母鸡"					;;
	"浓母鸡汤汁")	keyword="汤!母鸡汤"					;;
	"纯鸡汤")		keyword="汤!鸡汤"					;;
	"母鸡脯肉")		keyword="鸡脯!${keyword}"			;;
	"𬂁肝")			keyword="鸡𬂁肝!${keyword}"			;;
	"母鸡"*)		keyword="${keyword#母}!${keyword}"	;;
	"熟"*)			keyword="${keyword#熟}!${keyword}"	;;
	"虾仁")			keyword="虾!${keyword}"				;;
	"水发鸡松")		keyword="鸡松菌!${keyword}"			;;
	"水发笋子")		keyword="笋!${keyword}"				;;
	"干笋")			keyword="笋!${keyword}"				;;
	"有壳笋子")		keyword="笋"						;;
	*"冬笋"*)		keyword="笋!冬笋"					;;
	"水发兰片")		keyword="笋!${keyword}"				;;
	"水发兰片尖")	keyword="笋!${keyword}"				;;
	"玉兰片")		keyword="笋!${keyword}"				;;
	"水发玉兰片")	keyword="笋!${keyword}"				;;
	"干鱿鱼")		keyword="鱿鱼!${keyword}"			;;
	"水发鱿鱼")		keyword="鱿鱼!${keyword}"			;;
	"水发香菌")		keyword="香菌"						;;
	"水发青菌")		keyword="青菌"						;;
	"水发茗笋")		keyword="茗笋"						;;
	"水发响皮")		;;
	"水发还带")		;;
	"水发"*)		keyword="${keyword#水发}!${keyword}";;
	esac

	echo '\indexentry{'"${keyword}"'|hyperpage}{'"${page}"'}'
	echo -n "[${keyword}>${page}]" >&2
}

echo "Tinker index file ..." >&2

while read -r LINE
do
	[[ "${LINE}" =~ ^\\indexentry\{ ]] || continue
	KEYWORD="${LINE#*{}"
	KEYWORD="${KEYWORD%%\}*}"
	KEYWORD="${KEYWORD%%|*}"
	PAGE="${LINE##*{}"
	PAGE="${PAGE%\}*}"

	# Processing
	KEYWORD="${KEYWORD%%（*}"

	while [[ "${KEYWORD}" =~ 、 ]]
	do
		indexentry "${KEYWORD%%、*}" "${PAGE}"
		KEYWORD="${KEYWORD#*、}"
	done

	while [[ "${KEYWORD}" =~ 或 ]]
	do
		indexentry "${KEYWORD%%或*}" "${PAGE}"
		KEYWORD="${KEYWORD#*或}"
	done

	indexentry "${KEYWORD}" "${PAGE}"
done <"${INDEX_FILE}" >"${INDEX_FILE}.new"

echo >&2

mv "${INDEX_FILE}.new" "${INDEX_FILE}"

# vim: filetype=bash noautoindent nojoinspaces
# vim: fileencoding=utf-8 formatoptions+=m
# vim: textwidth=78 tabstop=4 shiftwidth=4 softtabstop=4
