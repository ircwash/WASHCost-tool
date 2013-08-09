var db= {

    /* Page 2 - Water */
    "water" : [
        { "label": "Borehole and handpump", "value": 1,  "recExBench" : { "min" : 3 , "max": 6 }, "capExBench" : { "min" : 20, "max": 61 } },
        { "label": "Mechanised borehole", "value": 1, "recExBench" : { "min" : 3, "max": 15  }, "capExBench" : { "min" : 30, "max": 131 } },
        { "label": "Single town schemes", "value": 1, "recExBench" : { "min" : 3, "max": 15 }, "capExBench" : { "min" : 30, "max": 131 } },
        { "label": "Multi town schemes", "value": 1, "recExBench" : { "min" : 3, "max": 15 }, "capExBench" : { "min" : 30, "max": 131 } },
        { "label": "Mixed town supply", "value":1, "recExBench" : { "min" : 3, "max": 15  }, "capExBench" : { "min" : 20, "max": 152 } }
    ] ,

    /* Page 3 - Population */
    "population" : [
        { "label": "Less than 500", "value": 1 },
        { "label": "Between 501 and 1100", "value": 2 },
        { "label": "Between 5,001 and 15,000", "value": 3 },
        { "label": "More than 15,000", "value": 4 }
    ] ,

    /* Page 4 - capital expenditure is a raw value */

    /* Page 5 - recurrent expenditure is a raw value */


    /* Page 6 - Time & Distance */
    "time" : [
        { "label" : "Less than 10", "value" : 1 },
        { "label" : "Between 10 and 30", "value" : 2 },
        { "label" : "Between 30 and 60", "value" : 3 },
        { "label" : "More than 60", "value" : 4 }
    ],

    /* Page 7- Quantity */
    "quantity" :[
        { "label" : "Less than 5 liters", "value" : "No service" },
        { "label" : "Between 5 and 20 liters", "value" : "Sub-standard service" },
        { "label" : "Between 21-60 liters", "value" : "Basic service" },
        { "label" : "More than 60 liters", "value" : "High service" }
    ],

    /* Page 8 - Quality */
    "quality" : [
        { "label" : "No testing", "value" : "No service" },
        { "label" : "One-off test after construction", "value" : "Sub-standard service" },
        { "label" : "Occasional and meets standards", "value" : "Basic service" },
        { "label" : "Regular and meets standards", "value" : "High service" }
    ],

    /* Page 9 - Reliability */
    "reliability" : [
        { "label" : "Works all the time", "value" : 1.5 },
        { "label" : "Works most of the days, but not &gt; 12 days", "value" : 1 },
        { "label" : "Many break-downs slow repairs", "value" : .25 },
        { "label" : "Not working", "value" : 0 }
    ]

}