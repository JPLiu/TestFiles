// ==UserScript==
// @name         B站界面优化
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  优化B站动态页和直播页界面布局
// @author       YourName
// @match        https://t.bilibili.com/*
// @match        https://live.bilibili.com/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // 动态页面优化
    if (window.location.host === 't.bilibili.com') {
        const style = document.createElement('style');
        style.textContent = `
            /* 隐藏左侧直播栏目 */
            .bili-dyn-live-users {
                display: none !important;
            }

            /* 隐藏右侧栏目 */
            .right {
                display: none !important;
            }

            /* 调整中间栏目宽度 */
            .bili-dyn-home--member > main:nth-child(2) {
                width: 65% !important;
            }
        `;
        document.head.appendChild(style);
    }

    // 直播页面优化
    if (window.location.host === 'live.bilibili.com') {
        const targetElement = document.getElementById('rank-list-vm');
        if (targetElement) {
            targetElement.style.cssText = `
                height: 14px !important;
                border-radius: 12px 12px 0 0 !important;
                background-color: #f8f8f8 !important;
            `;
        }
    }

    // 添加防抖处理
    let timeout;
    window.addEventListener('resize', function() {
        clearTimeout(timeout);
        timeout = setTimeout(() => {
            if (window.location.host === 't.bilibili.com') {
                const mainContent = document.querySelector('.bili-dyn-home--member > main:nth-child(2)');
                if (mainContent) {
                    mainContent.style.width = '65% !important';
                }
            }
        }, 200);
    });
})();
