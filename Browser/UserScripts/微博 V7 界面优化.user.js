// ==UserScript==
// @name         微博 V7 界面优化
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  优化微博 V7 界面，移除右侧栏、调整宽度、修改字体大小等
// @author       DeepSeek
// @match        https://weibo.com/*
// @match        https://s.weibo.com/*
// @grant        none
// ==/UserScript==

(function () {
    'use strict';

    // 等待页面加载完成
    window.addEventListener('load', function () {
        // 移除右侧栏
        removeElement('div[class^="Main_side"]'); // 主页面右侧栏
        removeElement('div[class="main-side"]'); // 搜索页右侧栏

        // 移除视频推荐栏目版头
        removeElement('div[class*="Banner_card_"]');

        // 修改左侧栏宽度
        setStyle('div[class^="Frame_side_"]', 'width: 182px !important');
        setStyle('div[class^="Nav_main"]', 'width: 182px !important');

        // 修改左侧栏位置
        setStyle('div[class*="Frame_content"]', 'margin-left: 2% !important');

        // 修改内容区宽度
        setStyle('div[class^="Frame_main_"]', 'width: 975px !important');
        setStyle('div[class^="Home_home"]', 'width: 975px !important');
        setStyle('div[class^="Main_wrap"]', 'width: 975px !important');
        setStyle('div[class^="Main_full"]', 'width: 975px !important');

        // 修改用户主页版头图高度
        setStyle('div[class^="woo-picture-main ProfileHeader_pic"]', 'height: 100px !important');

        // 修改信息流中视频和图片的显示大小
        setStyle('div[class^="card-video_videoBox"]', 'width: 75% !important; height: 75% !important');
        setStyle('div[class*="card-article_pic"]', 'width: 60% !important; height: 60% !important');

        // 修改信息流中图片的比例
        setStyle('div[class^="woo-picture-main woo-picture-square"]', 'width: 70% !important; height: 70% !important');
        setStyle('div[class="woo-picture-main woo-picture-square woo-picture-hover"]', 'width: 90px !important; height: 90px !important');

        // 修改信息流卡片、信息流、转发评论列表、图片大图右侧栏目评论、特殊栏目处理的文字大小
        setStyle('div[class^="card-link_text_"]', 'font-size: 13.5px !important; line-height: 25px !important');
        setStyle('div[class^="detail_wbtext_"]', 'line-height: 26px !important; font-size: 15.5px !important');
        setStyle('div[class="wbpro-list"]', 'line-height: 23.5px !important; font-size: 14.5px !important');
        setStyle('div[class="info woo-box-flex woo-box-alignCenter woo-box-justifyBetween"]', 'font-size: 13px !important');

        // 修改搜索页的宽度、位置和字体大小
        setStyle('div[class="m-main"]', 'margin-left: 2% !important');
        setStyle('div[class="main-full"]', 'width: 975px !important');
        setStyle('div[class="list"]', 'line-height: 23.5px !important; font-size: 14.5px !important');
        setStyle('textarea', 'width: 875px !important');
    });

    // 移除指定元素
    function removeElement(selector) {
        const elements = document.querySelectorAll(selector);
        elements.forEach(element => element.remove());
    }

    // 设置指定元素的样式
    function setStyle(selector, style) {
        const elements = document.querySelectorAll(selector);
        elements.forEach(element => element.style.cssText += style);
    }
})();
