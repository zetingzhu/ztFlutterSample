package com.example.v4

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

/**
 * @author: zeting
 * @date: 2025/9/2
 *
 */

class CountBean : ViewModel() {

    var curNum: MutableLiveData<Int> = MutableLiveData<Int>() // Android端点击次数

    var flutterNum: MutableLiveData<Int> = MutableLiveData<Int>() // Flutter端点击次数（接收到的）

    var getFlutterNum: MutableLiveData<Int> = MutableLiveData<Int>() // Flutter端点击次数（主动获取的）

}
