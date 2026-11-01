select year , country , mode , purpose , visits , nights , expend from {{source('travelpac', 'travelpac')}} where  ukos = 'Overseas residents'
and country = 'Channel Islands'