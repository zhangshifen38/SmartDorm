const IpPort = 'http://localhost:8888';

// 创建Date对象，获取当前时间, 返回值是string：yyyy-MM-dd
function getTime() {
    // var myDate = new Date();
    // return myDate.toLocaleDateString().split('/').join('-');
    var nowDate = new Date();
    var year = nowDate.getFullYear();
    var month = nowDate.getMonth() + 1 < 10 ? "0" + (nowDate.getMonth() + 1) : nowDate.getMonth() + 1;
    var day = nowDate.getDate() < 10 ? "0" + nowDate.getDate() : nowDate.getDate();
    var dateStr = year + "-" + month + "-" + day;
    return dateStr;
}

// 提交通知
function announce_submit() {
    var title = document.getElementById("announce-title").value;
    var content = document.getElementById("announce-content").value;
    if (title != "" && content != "") {
        // 自动获得当前发布日期
        var sdate = getTime(); // 写的函数，转化成yyyy-MM-dd的日期
        //alert(sdate);
        var wno = sessionStorage.getItem("CounselorUserName"); // 获得存储的职工号
        axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
        axios.defaults.transformRequest = [function (data) {
            let ret = ''
            for (let it in data) {
                ret += encodeURIComponent(it) + '=' + encodeURIComponent(data[it]) + '&'
            }
            return ret
        }]
        //alert("fasong");
        axios.post(IpPort+'/postAnnouncebyWno', {
            wno: wno,
            sdate: sdate,
            title: title,
            text: content
        })
            .then(function (response) {
                console.log(response.data);
                alert("提交成功!");
            })
            .catch(function (error) {
                console.log(error);
                alert("wrong")
            });
    }
    else {
        alert("通知的标题和内容都不可为空！")
    }
}

// 控制通知的提交键
function canAnnouceSubmit() {
    var title = document.getElementById("announce-title").value;
    var sub = document.getElementById("announce-submit");
    if (title != "") {
        sub.disabled = false;
    }
    else {
        sub.disabled = true;
    }
}

// ********************************** 宿管主界面 ************************************

// 点击查看详情按钮：查看通知详情
function showAnnouce() {
    document.getElementById("announce1").style = "display: block; background-color: rgba(30, 30, 30, 0.685);"
}

function closeAnnouce() {
    document.getElementById("announce1").style = "display: none;"
}

