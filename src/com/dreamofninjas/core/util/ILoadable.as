package com.dreamofninjas.core.util
{
import flash.events.IEventDispatcher;

public interface ILoadable extends IEventDispatcher	{
    function load(timeout:uint=0):void;
}
}