import React from 'react';
import { numberToColor } from './util';

function ToGenerate({ value, className }) { 
    return (
        <div
            className={"toGenerate" + (className ? " " + className : "")}
            style={value === 0 ? undefined : { backgroundColor: numberToColor(value) }}
        >
            {value === 0 ? "" : value}
        </div>
    );
}

export default ToGenerate;