HazardousZones.Settings.Items = {
    -- GasMask and Hazmat are controlled from SandboxVars from the future

    -- GasMask = {
    --     protections = {
    --         radiation = {
    --             value = SandboxVars.HZ.GasMaskRadiationProtectionValue
    --         },
    --         biological = {
    --             value = SandboxVars.HZ.GasMaskBiologicalProtectionValue
    --         }
    --     }
    -- },
    -- HazmatSuit = {
    --     protections = {
    --         radiation = {
    --             value = SandboxVars.HZ.HazmatSuitRadiationProtectionValue
    --         },
    --         biological = {
    --             value = SandboxVars.HZ.HazmatSuitBiologicalProtectionValue
    --         }
    --     }
    -- },
    
    HZCivilianGeiger = {
        FalsePositiveRatio = 10
    },
    HZIndustrialGeiger = {
        FalsePositiveRatio = 5
    },
    HZMilitaryGeiger = {
        FalsePositiveRatio = 3
    },
    HZMultiGasDetector = {
        FalsePositiveRatio = 5
    },
    HZMakeshiftBodyRadiationDetector = {
        MeasurementInterferenceMin = -250,
        MeasurementInterferenceMax = 250,
    },
    HZIodinePillSingle = {
        duration = 1.0, -- the duration how long the effects of the item lasts
        protections = {
            radiation = {
                value = 0.2,
                modifiers = {
                    bytraits = {
                        thinskinned = -0.5,
                        thickskinned = 0.5
                    }
                }
            },
        },
        effects = {
            foodSickness = {
                value = 10,
                modifiers = {
                    bytraits = {
                        weakstomach = 0.5,
                        irongut = -0.5
                    }
                }
            },
            thirst = {
                value = 0.1,
                modifiers = {
                    bytraits = {
                        highthirst = 0.5,
                        lowthirst = -0.5
                    }
                }
            },
            hunger = {
                value = -0.1,
                modifiers = {
                    bytraits = nil
                }
            },
            fatigue = {
                value = 0.05,
                modifiers = {
                    bytraits = nil
                }
            }
        },
        reductions = {
            radiation = {
                value = 25,
                modifiers = {
                    bytraits = {
                        slowhealer = -0.2,
                        fasthealer = 0.2
                    }
                }
            }
        }
    },
    HZToxiguardPillSingle = {
        duration = 1.0, -- the duration how long the effects of the item lasts
        protections = {
            biological = {
                value = 0.2,
                modifiers = {
                    bytraits = {
                        thinskinned = -0.5,
                        thickskinned = 0.5
                    }
                }
            },
        },
        effects = {
            foodSickness = {
                value = 10,
                modifiers = {
                    bytraits = {
                        weakstomach = 0.5,
                        irongut = -0.5
                    }
                }
            },
            thirst = {
                value = 0.1,
                modifiers = {
                    bytraits = {
                        highthirst = 0.5,
                        lowthirst = -0.5
                    }
                }
            },
            hunger = {
                value = -0.1,
                modifiers = {
                    bytraits = nil
                }
            },
            fatigue = {
                value = 0.05,
                modifiers = {
                    bytraits = nil
                }
            }
        },
        reductions = {
            biological = {
                value = 25,
                modifiers = {
                    bytraits = {
                        slowhealer = -0.2,
                        fasthealer = 0.2
                    }
                }
            }
        }
    },
    HZKILiquidMixture = {
        duration = 0.01, -- the duration how long the effects of the item lasts
        protections = {
            radiation = {
                value = 0,
                modifiers = {
                    bytraits = nil
                }
            },
        },
        effects = {
            foodSickness = {
                value = 10,
                modifiers = {
                    bytraits = {
                        weakstomach = 0.5,
                        irongut = -0.5
                    }
                }
            },
            thirst = {
                value = -0.5,
                modifiers = {
                    bytraits = nil
                }
            },
            hunger = {
                value = -0.5,
                modifiers = {
                    bytraits = nil
                }
            },
            fatigue = {
                value = -0.1,
                modifiers = {
                    bytraits = nil
                }
            }
        },
        reductions = {
            radiation = {
                value = 20,
                modifiers = {
                    bytraits = {
                        slowhealer = -0.2,
                        fasthealer = 0.2
                    }
                }
            }
        }
    },
    HZIndralineSyringe = {
        duration = 6.0, -- the duration how long the effects of the item lasts (x means x ingame hours)
        protections = {
            radiation = {
                value = 0.3,
                modifiers = {
                    bytraits = {
                        thinskinned = -0.3,
                        thickskinned = 0.3
                    }
                }
            },
            
        },
        effects = {
            foodSickness = {
                value = 30,
                modifiers = {
                    bytraits = {
                        weakstomach = 0.5,
                        irongut = -0.5
                    }
                }
            },
            thirst = {
                value = 0.3,
                modifiers = {
                    bytraits = {
                        highthirst = 0.5,
                        lowthirst = -0.5
                    }
                }
            },
            hunger = {
                value = 0,
                modifiers = {
                    bytraits = nil
                }
            },
            fatigue = {
                value = 0.3,
                modifiers = {
                    bytraits = nil
                }
            },
            panic = {
                value = 10,
                modifiers = {
                    bytraits = {
                        hemophobic = 10
                    }
                }
            }
        },
        reductions = {
            radiation = {
                value = 150,
                modifiers = {
                    bytraits = {
                        slowhealer = -0.2,
                        fasthealer = 0.2
                    }
                }
            }
        }
    },
    HZBioshieldRxSyringe = {
        duration = 6.0, -- the duration how long the effects of the item lasts (x means x ingame hours)
        protections = {
            biological = {
                value = 0.3,
                modifiers = {
                    bytraits = {
                        thinskinned = -0.3,
                        thickskinned = 0.3
                    }
                }
            },
            
        },
        effects = {
            foodSickness = {
                value = 30,
                modifiers = {
                    bytraits = {
                        weakstomach = 0.5,
                        irongut = -0.5
                    }
                }
            },
            thirst = {
                value = 0.3,
                modifiers = {
                    bytraits = {
                        highthirst = 0.5,
                        lowthirst = -0.5
                    }
                }
            },
            hunger = {
                value = 0,
                modifiers = {
                    bytraits = nil
                }
            },
            fatigue = {
                value = 0.3,
                modifiers = {
                    bytraits = nil
                }
            },
            panic = {
                value = 10,
                modifiers = {
                    bytraits = {
                        hemophobic = 10
                    }
                }
            }
        },
        reductions = {
            biological = {
                value = 150,
                modifiers = {
                    bytraits = {
                        slowhealer = -0.2,
                        fasthealer = 0.2
                    }
                }
            }
        }
    }
}