// ==UserScript==
// @name         微博V7界面深度优化
// @namespace    http://tampermonkey.net/
// @version      1.1
// @description  全面优化微博V7版界面布局和显示效果
// @author       YourName
// @match        https://weibo.com/*
// @match        https://s.weibo.com/*
// @grant        GM_addStyle
// @run-at       document-start
// ==/UserScript==

(function() {
    'use strict';

    // 通用样式优化
    const commonStyle = `
        /* 隐藏右侧边栏 */
        div[class^="Main_side"],
        div[class="main-side"] {
            display: none !important;
        }

        /* 视频推荐版头隐藏 */
        div[class*="Banner_card_"] {
            display: none !important;
        }

        /* 搜索页样式调整 */
        div.m-main {
            margin-left: 2% !important;
        }
        div.main-full {
            width: 975px !important;
        }
        div.list {
            line-height: 23.5px !important;
            font-size: 14.5px !important;
        }
        textarea {
            width: 875px !important;
        }
    `;

    // 主站样式优化
    const weiboStyle = `
        /* 左侧导航栏调整 */
        div[class^="Frame_side_"],
        div[class^="Nav_main"] {
            width: 182px !important;
        }

        /* 内容区位置调整 */
        div[class*="Frame_content"] {
            margin-left: 2% !important;
        }

        /* 主内容区宽度 */
        div[class^="Frame_main_"],
        div[class^="Home_home"],
        div[class^="Main_wrap"],
        div[class^="Main_full"] {
            width: 975px !important;
        }

        /* 用户主页版头高度 */
        div[class^="woo-picture-main ProfileHeader_pic"] {
            height: 100px !important;
        }

        /* 多媒体内容尺寸 */
        div[class^="card-video_videoBox"] {
            width: 75% !important;
            height: 75% !important;
        }
        div[class*="card-article_pic"] {
            width: 60% !important;
            height: 60% !important;
        }

        /* 图片比例调整 */
        div[class^="woo-picture-main woo-picture-square"] {
            width: 70% !important;
            height: 70% !important;
        }
        div[class="woo-picture-main woo-picture-square woo-picture-hover"] {
            width: 90px !important;
            height: 90px !important;
        }

        /* 文字排版优化 */
        div[class^="card-link_text_"] {
            font-size: 13.5px !important;
            line-height: 25px !important;
        }
        div[class^="detail_wbtext_"] {
            line-height: 26px !important;
            font-size: 15.5px !important;
        }
        div[class="wbpro-list"] {
            line-height: 23.5px !important;
            font-size: 14.5px !important;
        }
        div[class="info woo-box-flex woo-box-alignCenter woo-box-justifyBetween"] {
            font-size: 13px !important;
        }
    `;

    // 动态加载内容处理
    const observer = new MutationObserver(() => {
        document.querySelectorAll('[class^="Main_side"]').forEach(el => el.style.display = 'none');
    });

    // 初始化样式注入
    GM_addStyle(commonStyle);
    if (location.host === 'weibo.com') {
        GM_addStyle(weiboStyle);
        observer.observe(document.body, { childList: true, subtree: true });
    }

    // 窗口调整处理
    window.addEventListener('resize', () => {
        document.querySelectorAll('[class^="Frame_main_"]').forEach(el => {
            el.style.width = '975px !important';
        });
    });
})();
